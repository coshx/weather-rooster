class WeatherService < ActiveRecord::Base
  attr_accessible :active, :full_name, :homepage_url, :short_name, :zipcode_url_template
end
