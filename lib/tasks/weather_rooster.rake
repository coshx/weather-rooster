namespace :weather_rooster do
  desc "Pull the latest forecasts from the weather services"
  task :pull_latest_forecasts => :environment do
    services = WeatherService.where(:active => true)
    cities = City.all
    cities.each do |c|
      services.each {|s| s.pull_latest_forecast(c)} rescue nil
      sleep 1
    end
  end

  desc "Pull the latest actual data from NOAA"
  task :pull_latest_actual => :environment do
    NOAA.pull_latest_data(City.all)
  end

  desc "Pull next-day forecasts for eastern locations"
  task :pull_tomorrow_eastern => :environment do
    WeatherService.all.each do |service|
      City.find_all_by_timezone("Eastern Time (US & Canada)").each do |city|
        service.get_tomorrows_weather(city)
      end
    end
  end

  desc "Pull next-day forecasts for central locations"
  task :pull_tomorrow_central => :environment do
    WeatherService.all.each do |service|
      City.find_all_by_timezone("Central Time (US & Canada)").each do |city|
        service.get_tomorrows_weather(city)
      end
    end
  end

  desc "Pull next-day forecasts for mountain locations"
  task :pull_tomorrow_mountain => :environment do
    WeatherService.all.each do |service|
      City.find_all_by_timezone("Mountain Time (US & Canada)").each do |city|
        service.get_tomorrows_weather(city)
      end
    end
  end

  desc "Pull next-day forecasts for pacific locations"
  task :pull_tomorrow_pacific => :environment do
    WeatherService.all.each do |service|
      City.find_all_by_timezone("America/Los_Angeles").each do |city|
        service.get_tomorrows_weather(city)
      end
    end
  end
end
