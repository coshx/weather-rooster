class City < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :postal_code, :region_code, :timezone

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

  def self.find_by_slug(city_slug)
    the_city = ""

    self.all.each do |c|
      if city_slug == c.slug
        the_city = c
      end
    end

  #puts "that's what we got, fuck!" + city.name if city.present?
    the_city

  end

  def slug
    name.strip.gsub(' ', '_').gsub(/[^\w-]/, '').downcase
  end

end
