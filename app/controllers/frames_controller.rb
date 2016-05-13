class FramesController < ApplicationController
  before_action :set_frame, only: [:show, :edit, :update, :destroy]
  require 'net/http'
  # require 'paperclip-av-transcoder'

  # GET /frames
  # GET /frames.json
  def index
    @frames = Frame.all
  end

  # GET /frames/1
  # GET /frames/1.json
  def show
  end

  # GET /frames/new
  def new
    @frame = Frame.new
  end

  # GET /frames/1/edit
  def edit
  end


  def create_emotiondata_graph(method_name)
    #input will be data and it will output to front 
    file = File.join(Rails.root,'public', 'csv', "file.csv")
    CSV.open(file, "wb") do |csv|
      csv << Frame.attribute_names
      Frame.all.each do |user|
        csv << user.attributes.values
      end
    end

  end

  # POST /frames
  # POST /frames.json
  def create
    # @frame = Frame.new(frame_params)

    Frame.delete_all
    # Create new FFMPEG Movie
    movie = FFMPEG::Movie.new(File.join(Rails.root,'public', 'images', 'upload', 'movie.mp4'))
    # Parse FFMPEG Movie into frames
    movie.transcode("movie.mp4", "-r 1 /Users/nicolai/code/projects/emotionAPI_test/public/test2/image-%04d.jpeg") { |progress| puts progress } # 0.2 ... 0.5 ... 1.0

    # Send Frames to Amazon for storage
    
    # Grab frames from Amazon to send them to API

    # Grab directory where all files where stored from FFMPEG
    directory = Dir[File.join(Rails.root,'public', 'test2',"*")]

    # Loop through directory where images are stored and read each file
    directory.each do |image|
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
  end


    # movie = FFMPEG::Movie.new("/Users/nicolai/code/projects/emotionAPI_test/public/mark_zuck.mp4")
    # movie.transcode("movie.mp4", "-r 1 /Users/nicolai/code/projects/emotionAPI_test/public/test2/image-%04d.jpeg") { |progress| puts progress } # 0.2 ... 0.5 ... 1.0

    # Emotion Image API attempt
    # if @frame.save
    #   uri = URI('https://api.projectoxford.ai/emotion/v1.0/recognize')
    #   uri.query = URI.encode_www_form({
    #   })

    #   data = File.read("./public/full color pic.png")

    #   request = Net::HTTP::Post.new(uri.request_uri)
    #   # Request headers
    #   request['Ocp-Apim-Subscription-Key'] = ENV['MEA_SubscriptionKey1']
    #   # Request body
    #   # request.body = data
    #   request['Content-Type'] = 'application/octet-stream'
    #   request.body = data
    #   # '{"url": "http://localhost:4000/mark_zuck.mp4"}'
    #   response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    #       http.request(request)
    #   end

      # puts response.body
      # Capture response and save it into database each emotion at a time
      # Create chart from data; save it into db?
    # else
      # TBD
    # end
  # Failed Emotion Video API attempt
  #   uri = URI('https://api.projectoxford.ai/emotion/v1.0/recognizeinvideo')
  #   uri.query = URI.encode_www_form({
  #   })

  #   # data = File.read("./public/mark_zuck.mov")

  #   request = Net::HTTP::Post.new(uri.request_uri)
  #   # Request headers
  #   request['Ocp-Apim-Subscription-Key'] = '6f027d66bef64938872d4f519168495f'
  #   # Request body
  #   # request.body = data
  #   request['Content-Type'] = 'application/octet-stream'
  #   request.body = '{"url": "http://localhost:4000/mark_zuck.mp4"}'
  #   response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  #       http.request(request)
  #   end

  #   puts response.body


    # respond_to do |format|
    #   if @frame.save
    #     format.html { redirect_to @frame, notice: 'Frame was successfully created.' }
    #     format.json { render :show, status: :created, location: @frame }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @frame.errors, status: :unprocessable_entity }
    #   end
    # end
  # end 
  


  # PATCH/PUT /frames/1
  # PATCH/PUT /frames/1.json
  def update
    respond_to do |format|
      if @frame.update(frame_params)
        format.html { redirect_to @frame, notice: 'Frame was successfully updated.' }
        format.json { render :show, status: :ok, location: @frame }
      else
        format.html { render :edit }
        format.json { render json: @frame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frames/1
  # DELETE /frames/1.json
  def destroy
    @frame.destroy
    respond_to do |format|
      format.html { redirect_to frames_url, notice: 'Frame was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_frame
      @frame = Frame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def frame_params
      params.require(:frame).permit(:video_id, :video_timestamp, :anger, :contempt, :disgust, :fear, :happiness, :neutral, :sadness, :surprise)
    end
end
