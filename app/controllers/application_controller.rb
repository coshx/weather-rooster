class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :user_location, :remote_ip
  
  def remote_ip
    if request.remote_ip == '127.0.0.1'
      # Hard coded remote address
      '123.45.67.89'
    else
      request.remote_ip
    end
  end
  
  def user_location
    Geocoder.search(remote_ip)[0]
  end
  
  
end
