class HomeController < ApplicationController
  before_filter :require_user, :except => ['main']
  def main
    @user = User.new
    @user_session = UserSession.new
    # TODO make a way to show if there are more events
    # and then go display them!
    @upcoming = Event.find(:all, :order => "id desc", :limit => 10)
    respond_to do |format|
      format.html
    end
  end
  def home
    respond_to do |format|
      format.html
    end
  end
  def browse
    # TODO: make settable?
    events_per_page = 10
    @page = params[:page].to_i
    @pages = (Event.count / events_per_page).ceil.to_i
    @events = Event.find(:all, :order => "id desc", :limit => 10)
    respond_to do |format|
      format.html
    end
  end
end
