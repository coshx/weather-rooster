class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :closest_city, :request_city 
  
  def request_city
    
    if params[:city].present?
      city = Geocoder.search(params[:city])[0]
    else
      city = request.location
    end
    
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
  
  

end
