source 'https://rubygems.org'

ruby '2.2.3'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# AWS gems
# gem 'aws-sdk', '< 2'
gem 'aws-sdk', '>= 2.0.34'
gem 'aws-sdk-rails'

# Setting default values for model columns
gem "default_value_for", "~> 3.0.0"

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Heroku-need gem to enable platfor features
gem 'rails_12factor'

# Video processing
gem 'streamio-ffmpeg'

# Ziggeo for video capture/playback
gem "Ziggeo", :git => "https://github.com/Ziggeo/ZiggeoRubySdk.git"


# File uploading
gem 'paperclip', :git=> 'https://github.com/thoughtbot/paperclip', :ref => '523bd46c768226893f23889079a7aa9c73b57d68'
gem 'paperclip-av-transcoder'
# For video playback
gem "paperclip-ffmpeg", "~> 1.0.1"

# Graph library
gem "dygraphs-rails"
# Moment js for datetime manipulation of csv data
gem 'momentjs-rails'

# For background processes
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry'
  gem 'pry-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

