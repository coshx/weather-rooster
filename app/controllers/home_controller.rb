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
    
    @current_temp = @services.first[:service].current_forecasts.where(:city_id => @my_city.id).first.current_temp   
    
    @provider_name  = @services.first[:service].current_forecasts.where(:city_id => @my_city.id).first.weather_service.short_name
    
    @day = []
    
    4.times do |i|
      @day[i] = {}
      @day[i][:high] = @services.first[:service].current_forecasts.where(:city_id => @my_city.id).first["day_#{i}_high"]
      @day[i][:low] = @services.first[:service].current_forecasts.where(:city_id => @my_city.id).first["day_#{i}_low"]

    end

  end
end
