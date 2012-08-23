class HomeController < ApplicationController
  def landing
    @cities = City.all 
  end
  def thank_you
  end
  def main
    
    
  end
end
