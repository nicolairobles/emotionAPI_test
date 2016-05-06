class StaticController < ApplicationController
require 'net/http'

	def index
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
		request.body = '{"url": "http://localhost:4000/mark_zuck.mp4"}'
		response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
		    http.request(request)
		end

		puts response.body
	end 
	
end



# @ECHO OFF

# curl -v -X POST "https://api.projectoxford.ai/emotion/v1.0/recognizeinvideo" -H "Content-Type: application/octet-stream" -H "Ocp-Apim-Subscription-Key: 37892124263f4f0ca53d85b944caccd4" --data-ascii "{"url": "http://localhost/mark_zuck.mov"}" 
