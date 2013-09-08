class UserMailer < ActionMailer::Base
  default from: "rocurley@umd.edu"
  def event_email(user,event)
    @user=user
    @event=event
    mail(to: @user.email, subject: "You've been scheduled for #{event.activity.name}")
  end
end
