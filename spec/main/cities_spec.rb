require 'spec_helper'

describe ApplicationController do

  describe "find right location of the city" do
    city = FactoryGirl.create(:city, :name => 'San Francisco')
    city.latitude.should > 36
    city.latitude.should < 38 
  end
    
  
  describe "find closest city from the database" do
    city1 = FactoryGirl.create(:city, :name => 'San Francisco, CA')
    city2 = FactoryGirl.create(:city, :name => 'New York, NY')
    city3 = FactoryGirl.create(:city, :name => 'Austin, TX')
    city4 = FactoryGirl.create(:city, :name => 'Seattle, WA')    
    
    
  end
  
 
  
  
end
