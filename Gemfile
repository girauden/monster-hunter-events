source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


#Web
gem 'rails', '~> 5.1.0'
gem 'font-awesome-rails'
#DataBase
gem 'mongoid'
#Auth
gem 'devise'
gem 'pundit'
#Assets
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'font-awesome-rails'
#Datetimepicker
gem 'bootstrap'
gem 'momentjs-rails'
gem 'bootstrap4-datetime-picker-rails'
#Fix vulnerability
gem 'sprockets', '~> 3.7.2'
gem 'rails-html-sanitizer', '~> 1.0.4'
gem 'loofah', '~> 2.2.1'
#Keys protection
gem "figaro"

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'puma', '~> 3.0'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby '2.4.1'
