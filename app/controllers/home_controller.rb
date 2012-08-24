class HomeController < ApplicationController
  def landing
    @cities = City.all 
  end
  def thank_you
  end
  def main
    @cities = City.all
    @my_city = closest_city
    @services = WeatherService.where(:active => true)
    @services.map! {|s| {:service => s,
                               :score => s.recent_cc_score(@my_city) } }
    @services.sort! {|x,y| y[:score] <=> x[:score] }
  end
end
