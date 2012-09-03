require 'hipchat'

class ErrorMailer < ActionMailer::Base
  default :from => "weatherrooster@coshx.com"
  
  def error_notification(error)
  
     @error_title = error.title
     @error_description = error.description
     @error_time = error.created_at
     
     mail(
      :subject => "WeatherRooster: We got a new error, '#{@error_title}'",
      :to      => 'weather-rooster-monitoring@coshx.com',
      :tag     => 'weatherrooster'
    )

    client = HipChat::Client.new('89d684618c0efae42e66b30900961c')
    client['Weather Rooster'].send('ERROR', "We got an error, people. #{@error_title}, #{@error_description}, #{@error_time}", :notify => true, :color => 'red')
  
  end
  
end
