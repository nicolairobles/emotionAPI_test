class StaticController < ApplicationController
require 'net/http'

	def index
		Frame.delete_all
		# Create new FFMPEG Movie
		movie = FFMPEG::Movie.new("/Users/nicolai/code/projects/emotionAPI_test/public/mark_zuck.mp4")
		# Parse FFMPEG Movie into frames
		movie.transcode("movie.mp4", "-r 1 /Users/nicolai/code/projects/emotionAPI_test/public/test2/image-%04d.jpeg") { |progress| puts progress } # 0.2 ... 0.5 ... 1.0

		# Send Frames to Amazon for storage

		# Grab frames from Amazon to send them to API

		# Grab directory where all files where stored from FFMPEG
		file = File.read(File.join(Rails.root,'public', 'test2','image-0001.jpeg'))
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






	# # Emotion Video API Call to Submit Operation
	# 	uri = URI('https://api.projectoxford.ai/emotion/v1.0/recognizeinvideo')
	# 	uri.query = URI.encode_www_form({
	# 	})
	# 	puts "reached API"

	# 	# data = File.read("./public/mark_zuck.mov")
	# 	# ENV['MEA_SubscriptionKey1']
	# 	# '{"url": "http://localhost:4000/mark_zuck.mp4"}'

	# 	request = Net::HTTP::Post.new(uri.request_uri)
	# 	request['Ocp-Apim-Subscription-Key'] = '42a8c243a5ea47339c9e5bbe4f22a08b'
	# 	request['Content-Type'] = 'application/octet-stream'
	# 	request.body = File.read("./public/mark_zuck.mov")
	# 	puts "read file"
	# 	response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
	# 	    http.request(request)
	# 	end
	# 	p "request sent"
		# response.each_header do |key, value|
		#   p "#{key} => #{value}"
		# end
	# 	p "response received"
	# 	operation_location = response["operation-location"]
	# 	oid = operation_location.split("/")[6]
	# 	p response["operation-location"]




	# # Get result from operations
	# 	url = 'https://api.projectoxford.ai/emotion/v1.0/operations/' + oid
	# 	uri = URI(url)
	# 	uri.query = URI.encode_www_form({})
	# 	puts "reached Results API"

	# 	request = Net::HTTP::Get.new(uri.request_uri)
	# 	request['Ocp-Apim-Subscription-Key'] = 'fd89d512b5c345228039170679f1c097'
	# 	response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
	# 	    http.request(request)
	# 	end
	# 	response.each_header do |key, value|
	# 	  p "#{key} => #{value}"
	# 	end

	# 	p response.body
		# ENV['MEA_SubscriptionKey1']
		# Test w/ Curl
		# curl -v -X GET "https://api.projectoxford.ai/emotion/v1.0/operations/b055e518-bb28-4a3b-be3b-8445dce5232d" -H "Ocp-Apim-Subscription-Key: fd89d512b5c345228039170679f1c097"

	end 
	
end
