class ErrorMailer < ActionMailer::Base
  default :from => "weatherrooster@coshx.com"
  
  def error_notification(error)
  
     @error_title = error.title
     @error_description = error.description
     @error_time = error.created_at
     
     mail(
      :subject => "WeatherRooster: We got a new error, '#{@error_title}'",
      :to      => 'gabe@coshx.com, mikhail@coshx.com',
      :tag     => 'weatherrooster'
    )
  
  end
  
end
