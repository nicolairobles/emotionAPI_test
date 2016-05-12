class VideosController < ApplicationController
  require 'net/http'
  before_action :set_video, only: [:show, :edit, :update, :destroy]

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
    # if @video.save
    #   # Splices videos into frames (for each second)
    #   movie = FFMPEG::Movie.new("./public/mark_zuck.mp4")
    #   movie.transcode("movie.mp4", "-r 1 /public/test2/image-%04d.jpeg") { |progress| puts progress } # 0.2 ... 0.5 ... 1.0
    # else
    #   # TBD
    # end
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    # Store file in app for immediate purposes
    file = params[:video][:upload][:file].read
    name = params[:video][:upload][:file].original_filename
    directory = "public/images/upload"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(file) }
    flash[:notice] = "File uploaded"
    redirect_to "/videos/new"
    @video = Video.new(video_params)
    binding.pry
    # Create FFMPEG Movie file
    movie = FFMPEG::Movie.new(path)
    # Splice video intro frames
    movie.transcode("movie.mp4", "-r 1 /Users/nicolai/code/projects/emotionAPI_test/public/test2/image-%04d.jpeg") { |progress| puts progress } # 0.2 ... 0.5 ... 1.0
    # Redirect to FramesController
    redirect_to url_for(:controller => :frames, :action => :create, :param1 => :val1, :param2 => :val2) will results in /contorller_name/action_name?param1=val1&param2=val2

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
