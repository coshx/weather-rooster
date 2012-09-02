set :url, "http://staging.weatherrooster.com"
set :branch, "develop"
default_environment['SECONDARY_ENV'] = stage
set(:rvm_ruby_string) {"ruby-1.9.3@weather-rooster-#{stage}"}
