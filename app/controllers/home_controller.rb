class HomeController < ApplicationController
  def landing

  GeoIp.api_key = '6881154858158dd019be66f40bbc3c31e41d6f9fc6bcb411759ca4c2be2ea8c8'
   ip_address = request.remote_ip
   GeoIp.geolocation(ip_address) 

    binding.pry

  end
  def thank_you
  end
  def main
    
    
  end
end
