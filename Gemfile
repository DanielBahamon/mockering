source 'https://rubygems.org'
# ruby "2.6.6"
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'pg'
gem 'rails_real_favicon'
gem 'sassc', '~> 2.1.0'
gem 'bootstrap', '~> 4.5'
gem 'sassc-rails', '>= 2.1.0'
gem 'jquery-rails'
# gem 'dragonfly', '~> 1.2' 
gem 'jquery-ui-rails', '~> 5.0', '>= 5.0.5'
gem 'avatar_magick', '~> 1.0', '>= 1.0.2'
gem 'toastr-rails', '~> 1.0'
gem 'devise', '~> 4.2'
gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap'
gem 'acts_as_votable', '~> 0.12.1'
gem 'acts-as-taggable-on', '~> 6.0'
gem 'friendly_id', '~> 5.2.4'
gem 'cocaine', '~> 0.5.5'
gem 'paperclip', '~> 5.1.0'
gem 'font-awesome-sass'
gem 'aws-sdk', '~> 2.8'
gem 'rails_autolink', '~> 1.1', '>= 1.1.6'
gem 'jquery-atwho-rails', '~> 1.5', '>= 1.5.4'
gem 'redcarpet', '~> 3.5'
gem 'videotime'
# gem 'aws-sdk', '~> 3'
gem 'paperclip-av-transcoder', '~> 0.6.4'
gem 'rails-jquery-autocomplete', '~> 1.0', '>= 1.0.5'
# gem "paperclip-ffmpeg", "~> 1.2.0"
gem 'streamio-ffmpeg', '~> 3.0', '>= 3.0.2'
# gem 'elastic_transcoder', '~> 0.0.3'
gem 'ransack'
gem 'activesupport', '~> 5.1', '>= 5.1.7'
gem 'masonry-rails', '~> 0.2.4'
gem 'impressionist', '~>1.6.1'
gem 'activity_notification', '~> 2.1', '>= 2.1.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.7'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'haml', '~> 5.1', '>= 5.1.2'
gem 'simple_form', '~> 5.0', '>= 5.0.2'
gem 'omniauth', '~> 1.6'
gem 'omniauth-facebook', '~> 4.0'
gem 'omniauth-google-oauth2', '~> 0.8.0'
gem 'mysql-binuuid-rails'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0', group: :production
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.3.6'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
