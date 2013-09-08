class HomeController < ApplicationController
  before_filter :require_user, :except => ['main']
  def main
    @user = User.new
    @user_session = UserSession.new
    # TODO make a way to show if there are more events
    # and then go display them!
    @upcoming = Event.find(:all, :order => "id desc", :limit => 5)
    respond_to do |format|
      format.html
    end
  end
  def home
    respond_to do |format|
      format.html
    end
  end
end
