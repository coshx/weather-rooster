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
      if city.present?
        city = Geocoder.search("San Francisco")[0] if city.city.blank?
      else
        city = Geocoder.search("San Francisco")[0]
      end

      else
      city = request.location
    end


      logger.info "Class: " + city.class.to_s

    city

  end

  def closest_city
    # if there's sity in the sesion, use it, otherwise find it through find_closest_city
    if cookies[:the_city].present? and params[:city].blank?
      city = City.find_by_id(cookies[:the_city])
    else
      if params[:city].present?
        city = City.find_by_slug(params[:city])
        cookies[:the_city] = city.id if city.present?
      end
      if city.blank?
        city = request_city
        if city.respond_to?(:latitude)
          city = find_closest_city(city)
        else
          city = City.all.sample()
        end
      end
    end

    city

  end

  def find_closest_city(city)
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

  cookies[:the_city] = city.id
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
