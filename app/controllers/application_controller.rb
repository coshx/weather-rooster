class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :closest_city, :request_city, :translate_status


  def translate_status(api_name)
    status = WeatherStatus.find_by_api_name(api_name)

    if status.blank?
      Error.create(:title => 'New weather description', :description => api_name)
      WeatherStatus.create(:api_name => api_name)
      "partly-cloudy"
    else
      if status.name.blank?
        "partly-cloudy"
      else
        status.name
      end
    end

  end

  def request_city
    if params[:city].present?
      city = Geocoder.search(params[:city])[0]
      city = Geocoder.search("San Francisco")[0] if city.city.blank?
      cookies[:city] = city
    else

      if cookies[:city].present?
        city = cookies[:city]
      else
        city = request.location
      end

    end

    if city.respond_to(:city)
      city = Geocoder.search("San Francisco")[0]
      cookies[:city] = city
    end

    city

  end

  def closest_city
    # if there's sity in the sesion, use it, otherwise find it through find_closest_city
    find_closest_city
  end

  def find_closest_city
    cities = City.all

      city = request_city
      la1 = city.latitude
      lo1 = city.longitude

    smaller_distance = 1000000000.00000001
    city = cities.first

    cities.each do |c|

      la2 = c.latitude
      lo2 = c.longitude

      l = Math.sqrt( (la1-la2) ** 2 + (lo1-lo2) ** 2 )
      if l < smaller_distance
        smaller_distance = l
        city = c
      end

    end

  city

  end

   def find_closest_city_to(city)
    cities = City.all

      la1 = city.latitude
      lo1 = city.longitude

    smaller_distance = 1000000000.00000001
    city = cities.first

    cities.each do |c|

      la2 = c.latitude
      lo2 = c.longitude

      l = Math.sqrt( (la1-la2) ** 2 + (lo1-lo2) ** 2 )
      if l < smaller_distance
        smaller_distance = l
        city = c
      end

    end

  city

  end

end
