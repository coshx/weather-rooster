module ApplicationHelper


  def slug(name)
    str = "#{name}"
    str.gsub! /['`]/,""
    str.gsub! /\s*@\s*/, " at "
    str.gsub! /\s*&\s*/, " and "
    str.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'
    str.gsub! /_+/,"_"
    str.gsub! /\A[_\.]+|[_\.]+\z/,""
    str.downcase!
    return str
  end


  def translate_status(api_name)
    #status = Weather_status.find_by_api_name(api_name)
    #return status.name
  end

  #Time.current
  def weather_record_valid?(the_time)
    true if (Time.current - the_time) < 36.hours
  end

  def current_forecast_valid?(the_time)
    true if (Time.current - the_time) < 20.minutes
  end

  def noaa_weather_record_valid?(the_time)
    true if (Time.current - the_time) < 100.hours
  end


end
