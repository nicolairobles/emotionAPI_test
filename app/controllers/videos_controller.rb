class VideosController < ApplicationController
  require 'net/http'
  require 'csv'
  require 'open-uri'

  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :aws_client

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.create(video_params)

    # Store file in app for immediate purposes
    # 
    # HOW TO STORE VIDEO AT AWS
    # 
    # video_file = params[:video][:upload][:file].read
    # video_file_name = params[:video][:upload][:file].original_filename
    # video_directory = "public/images/upload"
    # path = File.join(video_directory, video_file_name)

    # # Writes video into designated directory
    # File.open(path, "wb") { |f| f.write(video_file) }
    # flash[:notice] = "File uploaded"

    # Splice video
    file_name = @video.video_file_file_name
    Rails.logger.info "file_name: #{file_name.inspect}"
    remote_path = @video.video_file.url
    Rails.logger.info "remote_path: #{remote_path.inspect}"

    # open(file_name, 'wb') do |file|
    #   file << open(remote_path).read
    # end
    # p file_name
    Dir.mkdir(File.join(Rails.root, 'tmp', "videos"))
    local_path = "#{Rails.root}/tmp/videos/#{file_name}"
    Rails.logger.info "local_path: #{local_path.inspect}"

    open(local_path, 'wb') do |file|
      file << open(remote_path).read
    end
    # puts "local_path: #{local_path.inspect}"
    Dir.mkdir(File.join(Rails.root, 'tmp', "images","frames"))

    splice_video(local_path, file_name)

    # splice_video(remote_path, file_name)

    # # Retrieve emotion data from API based on frames
    # # 
    # # HOW TO RETRIEVE IMAGE FRAMES FROM AWS
    # #
    # frames_dir_path = Dir[File.join(Rails.root,'public', 'images',"frames","*")]

    frames_dir_path = Dir[File.join(Rails.root,'tmp', 'images',"frames","*")]
    retrieve_api_data(frames_dir_path)

    # Delete frames locally
    clean_up_local_image_files(frames_dir_path)

    # # Create graph of data
    create_APIData_graph(Frame)
    
    # Redirect to same page
    redirect_to @video 

    # respond_to do |format|
    #   if @video.save
    #     format.html { redirect_to @video, notice: 'Video was successfully created.' }
    #     format.json { render :show, status: :created, location: @video }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @video.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def clean_up_local_image_files(directory)
    directory.each do |fname|
      File.delete(fname)
    end
  end

  def splice_video(path_of_video, file_name)
    Rails.logger.info "inside splice_video"
    # Create FFMPEG Movie file
    movie_to_splice = FFMPEG::Movie.new(path_of_video)
    Rails.logger.info "movie_to_splice: #{movie_to_splice.inspect}"
    Rails.logger.info "file_name: #{file_name.inspect}"

    # Splice video intro frames

    movie_to_splice.transcode(file_name, "-r 1 #{Rails.root}/tmp/images/frames/#{file_name}-%04d.jpeg") { |progress| puts progress } # 0.2 ... 0.5 ... 1.0
    Rails.logger.info "after transcoding"

    # Store image in AWS; done in before action
    # aws_client

    Dir.foreach("#{Rails.root}/tmp/images/frames/") do |fname|
      puts fname
      next if fname == '.' or fname == '..'
      # uplaod each file to s3
      s3 = Aws::S3::Resource.new
      p s3.bucket('emotizeframes').object(fname).upload_file("#{Rails.root}/tmp/images/frames/#{fname}")
    end


    # Delete video locally
    File.delete(path_of_video)

    # Redirect to FramesController
    # redirect_to url_for(:controller => :frames, :action => :create, :param1 => :val1, :param2 => :val2) will results in /contorller_name/action_name?param1=val1&param2=val2
  end 

  def aws_client
    @aws_client ||= Aws.config.update({
      region: 'us-west-2',
      credentials: Aws::Credentials.new(ENV.fetch("AWS_ACCESS_KEY_ID"), ENV.fetch('AWS_SECRET_ACCESS_KEY'))
    })
  end 

  def retrieve_api_data(frames_directory)
    Frame.delete_all
    p "Deleted previous frames"
    p "Retrieving API data"
    # Loop through directory where images are stored and read each file
    frames_directory.each do |image|
    # Emotion Image API call
      # Set parameters
      uri = URI('https://api.projectoxford.ai/emotion/v1.0/recognize')
      uri.query = URI.encode_www_form({
      })
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Ocp-Apim-Subscription-Key'] = ENV["MEA_SubscriptionKey1"]
      request['Content-Type'] = 'application/octet-stream'
      # Read in appropriate file
      request.body = File.read("#{image}")
      # Make HTTP request to API
      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
          http.request(request)
      end
      # Pull out JSON data from response
      puts response.body
      json = JSON.parse(response.body).first # gets array
      json_scores = json["scores"]
      anger = json_scores["anger"]
      contempt = json_scores["contempt"]
      disgust = json_scores["disgust"]
      fear = json_scores["fear"]
      happiness = json_scores["happiness"]
      neutral = json_scores["neutral"]
      sadness = json_scores["sadness"]
      surprise = json_scores["surprise"]
      # Inject data into Frames table
      @frame = Frame.create(
        anger: anger, 
        contempt: contempt, 
        disgust: disgust, 
        fear: fear, 
        happiness: happiness, 
        neutral: neutral, 
        sadness: sadness,
        surprise: surprise)
    end
    p "Successfully retrieved emotionAPI data"
  end 

  def create_APIData_graph(table)
    p "Creating API Data graph"
    # Create CSV file
    file = File.join(Rails.root,'tmp', "file.csv")
    CSV.open(file, "wb") do |csv|
      # csv << table.attribute_names[3,8].unshift("id")
      csv << table.attribute_names[2,9]
      table.all.each do |user|
        csv << user.attributes.values[2,9]
      end
      # csv << table.attribute_names
      # frame_count_secs = 01
      # frame_count_mins = 00
      # frame_timestamp = ":00"

      # table.all.each do |user|
      #   if frame_count_secs%60 == 0
      #     frame_count_secs = 0
      #     frame_count_mins += 1
      #     frame_timestamp = "#{frame_count_mins}:#{frame_count_secs}"
      #   else
      #     frame_count_secs += 1
      #     frame_timestamp = "#{frame_count_mins}:#{frame_count_secs}"
      #   end
      #     csv << user.attributes.values[3,8].unshift(frame_timestamp)
      #   # csv << user.attributes.values
      # end
    end
    # Upload to AWS
    s3 = Aws::S3::Resource.new
    p "csv output"
    p s3.bucket('emotizecsvfile').object("emotizecsvfile").upload_file("#{Rails.root}/tmp/file.csv")

    p "Successfully created CSV"
    # Render CSV data for front-end implementation of graph
    p "Creating graph"


    p "Created and rendered graph"
  end 


  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:time_length, :video_file)
    end
end
