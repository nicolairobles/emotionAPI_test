class StaticController < ApplicationController
require 'net/http'
# require 'paperclip-av-transcoder'

	def index
		# movie = FFMPEG::Movie.new("/Users/nicolai/code/projects/emotionAPI_test/public/mark_zuck.mp4")
		# movie.transcode("movie.mp4", "-r 1 /Users/nicolai/code/projects/emotionAPI_test/public/test2/image-%04d.jpeg") { |progress| puts progress } # 0.2 ... 0.5 ... 1.0

		# Emotion Image API attempt
		# 	uri = URI('https://api.projectoxford.ai/emotion/v1.0/recognize')
		# 	uri.query = URI.encode_www_form({
		# 	})

		# 	data = File.read("./public/full color pic.png")

		# 	request = Net::HTTP::Post.new(uri.request_uri)
		# 	# Request headers
		# 	request['Ocp-Apim-Subscription-Key'] = '6f027d66bef64938872d4f519168495f'
		# 	# Request body
		# 	# request.body = data
		# 	request['Content-Type'] = 'application/octet-stream'
		# 	request.body = data
		# 	# '{"url": "http://localhost:4000/mark_zuck.mp4"}'
		# 	response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
		# 	    http.request(request)
		# 	end

		# puts response.body


	# Failed Emotion Video API attempt
		uri = URI('https://api.projectoxford.ai/emotion/v1.0/recognizeinvideo')
		uri.query = URI.encode_www_form({
		})

		# data = File.read("./public/mark_zuck.mov")

		request = Net::HTTP::Post.new(uri.request_uri)
		# Request headers
		request['Ocp-Apim-Subscription-Key'] = '6f027d66bef64938872d4f519168495f'
		# Request body
		# request.body = data
		request['Content-Type'] = 'application/octet-stream'
		request.body = File.read("./public/mark_zuck.mov")
		# '{"url": "http://localhost:4000/mark_zuck.mp4"}'
		response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
		    http.request(request)
		end

		puts response.body
	end 
	
end



# @ECHO OFF

# curl -v -X POST "https://api.projectoxford.ai/emotion/v1.0/recognizeinvideo" -H "Content-Type: application/octet-stream" -H "Ocp-Apim-Subscription-Key: 6f027d66bef64938872d4f519168495f" --data-ascii "/Users/nicolai/code/projects/emotionAPI_test/public/mark_zuck.mov"

# curl -X POST --include 'https://eyeris-emovu1.p.mashape.com/api/video/' \
#   -H 'X-Mashape-Key: OOghw9oNBdmshNzjFziMzB9rwI5Rp16MgWjjsncOl0dEYRuhtY' \
#   -H 'LicenseKey: 33146918814424241036407334961043311688141919214844242046307216911344811625' \
#   -F 'videoFile=@/Users/nicolai/code/projects/emotionAPI_test/public/mark_zuck.mp4'

# FFMPEG
# ffmpeg -i videofile.mpg -r 1 image-%04d.jpeg
# ffmpeg -i /Users/nicolai/code/projects/emotionAPI_test/public/mark_zuck.mp4 -r 1 /Users/nicolai/code/projects/emotionAPI_test/public/videos/image-%04d.jpeg

# -i is the input video file with path 
# the jpeg filename simply saves jpegs (you can also use png, bmp, tiff etc) with the name 
# 4 place holding numbers, e.g. image-0001. 
# The -r command is the frames to capture and the reverse of how you would expect it to work. 1 will save a frame every second while 0.5 will save every 2 seconds, 0.2 every 5 seconds, 0.1 every 10 seconds, 0.0167 for 60 seconds and etc. Use 1/seconds in Windows Calculator to get the ratio you need.
# Read More: https://www.raymond.cc/blog/extract-video-frames-to-images-using-vlc-media-player/
