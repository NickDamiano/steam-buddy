source 'https://rubygems.org'
group :test do
  gem 'vcr'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'webmock'
end

group :production do
  gem 'unicorn'
end

group :development do 
  gem 'capistrano', '~> 2.15.1'
  gem 'rvm-capistrano', require: false
  gem 'capistrano-resque', '~> 0.2.2', require: false
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'autoprefixer-rails'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

gem 'pry-byebug', group: :development

gem 'hirb'

gem 'resque'

gem 'pusher'

gem 'rack'

ruby "2.2.1"
