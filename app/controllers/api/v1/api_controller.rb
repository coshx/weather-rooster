module Api
  module V1

    class ApiController < ApplicationController

      respond_to :json

      def providers
          @services = WeatherService.where(:active => true)
          render json:{"WeatherRooster providers" => @services}
      end

      def cities
          @cities = City.all
          render json:{"WeatherRooster cities" => @cities}
      end

      def city_detail

        city = find_closest_city_to(Geocoder.search(params[:city])[0])

        @services = WeatherService.where(:active => true)
        @services.map! {|s| {:service => s,
                               :score => s.recent_cc_score(city) } }
        @services.sort! {|x,y| y[:score] <=> x[:score] }
        render json:{"WeatherRooster rating for #{city.name}" => @services}
      end




      def weather_records
          weather_records = WeatherRecord.all
          @weather_records = []

          weather_records.each do |w|
            @weather_records << w if w.created_at.strftime("%D") == Date.parse(params[:date]).strftime("%D")
          end

          render json:{"WeatherRooster weather_records for #{Date.parse(params[:date]).strftime("%D")}" => @weather_records}
      end


    end

  end
end
