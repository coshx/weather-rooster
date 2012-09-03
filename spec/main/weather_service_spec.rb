require 'spec_helper'

describe WeatherService do

  describe "relations" do
    it { should have_many :weather_records }    
    it { should have_many :current_forecasts }    
  end
 
   
end
