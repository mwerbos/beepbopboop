# Load the rails application
require File.expand_path('../application', __FILE__)
ActionMailer::Base.delivery_method=:smtp
ActionMailer::Base.smtp_settings = {
  :address => 'smtp.gmail.com',
  :port => 587,
  :user_name => "what9000server@gmail.com",
  :password => File.read(File.join(Rails.root,"config/password.txt"))[0..-2],
  :authentication => :plain,
  :enable_starttls_auto => true,
}

# Initialize the rails application
Velociraptor::Application.initialize!
