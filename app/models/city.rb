class City < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :postal_code, :region_code
  
  geocoded_by :name
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, :reverse_geocode, :if => :name_changed?

  has_many :weather_records
  has_many :current_forecasts

reverse_geocoded_by :latitude, :longitude do |obj,results|
  if geo = results.first
     obj.postal_code = geo.postal_code
     obj.region_code = geo.state_code
  end
end

end
