source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'sqlite3'
gem 'gravatar_image_tag'
gem 'will_paginate', '~> 3.0.2'
gem 'jquery-rails'
gem 'rack', '1.3.3'
gem 'multi_json'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :assets do
	gem 'sass-rails', "~> 3.1.0"
 	gem 'coffee-rails', "~> 3.1.0"
	gem 'uglifier'
end

group :development do 
	gem 'rspec-rails', '2.6.1'
    gem 'annotate', '2.4.0'
	gem 'faker', '0.3.1'
	gem 'hirb'
end

group :test do 
	gem 'rspec-rails', '2.6.1'
	gem 'webrat', '0.7.1'
  gem 'factory_girl_rails', '1.0'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
  gem "spork", "> 0.9.0.rc"
  gem "guard-spork"
  gem 'growl'
end
