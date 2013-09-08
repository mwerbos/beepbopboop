class UserMailer < ActionMailer::Base
  default from: "what9000server@gmail.com"
  def event_email(users,event)
    @users=users
    @event=event
    u = @users.map{ |user| user.email }
    puts "EMAIL ADDRESSES:"
    puts u
    mail(to: u, subject: "You've been scheduled for #{event.activity.name}")
  end
end
