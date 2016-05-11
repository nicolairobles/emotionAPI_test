class StaticController < ApplicationController
require 'net/http'

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
	# 	response.each_header do |key, value|
	# 	  p "#{key} => #{value}"
	# 	end
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
	# 	# ENV['MEA_SubscriptionKey1']
	# 	# Test w/ Curl
	# 	# curl -v -X GET "https://api.projectoxford.ai/emotion/v1.0/operations/b055e518-bb28-4a3b-be3b-8445dce5232d" -H "Ocp-Apim-Subscription-Key: fd89d512b5c345228039170679f1c097"

	end 
	
end
