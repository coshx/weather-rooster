require "whenever/capistrano"
set :whenever_command, "bundle exec whenever"

set :url, "http://www.weatherrooster.com"
set :branch, "master"
default_environment['SECONDARY_ENV'] = stage
set :rvm_ruby_string, "ruby-1.9.3@weather-rooster"
