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

  def api
  end


  def contact
  end

  def city_details
    @my_city = closest_city
    @services = WeatherService.where(:active => true)
    @services.map! {|s| {:service => s,
                               :score => s.recent_cc_score(@my_city) } }
    @services.sort! {|x,y| y[:score] <=> x[:score] }

    the_service =  @services.first[:service].current_forecasts.where(:city_id => @my_city.id)



    #weather
     @cities = City.all

     @current_temp = the_service.first.current_temp

    @provider_name  = the_service.first.weather_service.short_name

    @day = []

    4.times do |i|
      @day[i] = {}

      # If the provider doesn't have enough future data, we change it to another provider
      if the_service.first["day_#{i}_high"]==nil
        the_service =  @services[1][:service].current_forecasts.where(:city_id => @my_city.id)
      end

      @day[i][:high] = the_service.first["day_#{i}_high"]
      @day[i][:low] = the_service.first["day_#{i}_low"]
      @day[i][:string] = translate_status(the_service.first["day_#{i}_string"])
      @day[i][:api_string] = the_service.first["day_#{i}_string"]

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

    the_service =  @services.first[:service].current_forecasts.where(:city_id => @my_city.id)


    @current_temp = the_service.first.current_temp

    @provider_name  = the_service.first.weather_service.short_name

    @day = []

    4.times do |i|
      @day[i] = {}

      # If the provider doesn't have enough future data, we change it to another provider
      if the_service.first["day_#{i}_high"]==nil
        the_service =  @services[1][:service].current_forecasts.where(:city_id => @my_city.id)
      end

      @day[i][:high] = the_service.first["day_#{i}_high"]
      @day[i][:low] = the_service.first["day_#{i}_low"]
      @day[i][:string] = translate_status(the_service.first["day_#{i}_string"])
      @day[i][:api_string] = the_service.first["day_#{i}_string"]
    end
  end
end
