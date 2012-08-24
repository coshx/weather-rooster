# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 15.minutes do
  rake "weather_rooster:pull_latest_forecasts"
end

every 30.minutes do
  rake "weather_rooster:pull_latest_actual"
end

# i think this is noon pacific during DST
every :day, :at => '7pm' do
  rake 'weather_rooster:pull_tomorrow_pacific'
end

every :day, :at => '6pm' do
  rake 'weather_rooster:pull_tomorrow_mountain'
end

every :day, :at => '5pm' do
  rake 'weather_rooster:pull_tomorrow_central'
end

every :day, :at => '4pm' do
  rake 'weather_rooster:pull_tomorrow_eastern'
end
