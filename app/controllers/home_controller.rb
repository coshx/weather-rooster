class HomeController < ApplicationController
  def landing

  GeoIp.api_key = '6881154858158dd019be66f40bbc3c31e41d6f9fc6bcb411759ca4c2be2ea8c8'
   @ip_address = request.remote_ip
   @geolocation = GeoIp.geolocation('209.85.227.104') #GeoIp.geolocation(ip_address) 
  
  end
  def thank_you
  end
  def main
    
    
  end
end
