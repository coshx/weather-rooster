class HomeController < ApplicationController

  def status
    @cities = City.all
    @my_city = closest_city
    @services = WeatherService.where(:active => true)
    #binding.pry
    #@services.map! {|s| {:service => s, :score => s.recent_cc_score(@my_city) } }
  end
  
  def about
  end

  def contact
  end

  def city_details
    @my_city = closest_city
    @services = WeatherService.where(:active => true)
    @services.map! {|s| {:service => s,
                               :score => s.recent_cc_score(@my_city) } }
    @services.sort! {|x,y| y[:score] <=> x[:score] }
    
    
    
    
    #weather
     @cities = City.all
     
     @current_temp = @services.first[:service].current_forecasts.where(:city_id => @my_city.id).first.current_temp   
    
    @provider_name  = @services.first[:service].current_forecasts.where(:city_id => @my_city.id).first.weather_service.short_name
    
    @day = []
    
    4.times do |i|
      @day[i] = {}
      @day[i][:high] = @services.first[:service].current_forecasts.where(:city_id => @my_city.id).first["day_#{i}_high"]
      @day[i][:low] = @services.first[:service].current_forecasts.where(:city_id => @my_city.id).first["day_#{i}_low"]
      @day[i][:string] = translate_status(@services.first[:service].current_forecasts.where(:city_id => @my_city.id).first["day_#{i}_string"])
      @day[i][:api_string] = @services.first[:service].current_forecasts.where(:city_id => @my_city.id).first["day_#{i}_string"]

    end
    
    
  end
  
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
      @day[i][:string] = translate_status(@services.first[:service].current_forecasts.where(:city_id => @my_city.id).first["day_#{i}_string"])
      @day[i][:api_string] = @services.first[:service].current_forecasts.where(:city_id => @my_city.id).first["day_#{i}_string"]
    end
  end
end
