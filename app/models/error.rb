class Error < ActiveRecord::Base
  attr_accessible :description, :title
  before_save :notify_about_error
  
  
  def notify_about_error
    ErrorMailer.error_notification(self).deliver
  end
  
  
end
