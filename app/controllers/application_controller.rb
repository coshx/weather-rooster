class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :closest_city  
  

  def closest_city
    # if there's sity in the sesion, use it, otherwise find it through find_closest_city
    find_closest_city    
  end  
  
  def find_closest_city
    cities = City.all
    
    la1 = request.location.latitude
    lo1 = request.location.longitude
    
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
