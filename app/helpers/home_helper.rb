module HomeHelper

  def prepare_graph_data(city, services)
    noaa = services.find {|s| s.short_name == "NOAA"}
    end_date = noaa.weather_records.where(:city_id => city.id).order(:created_at).last.weather_date
    lows = {}
    highs = {}
    services.each do |s|
      data = s.recent_data(city, end_date)
      lows[s] = data[:lows]
      highs[s] = data[:highs]
    end
    {:lows => lows, :highs => highs}
  end

end
