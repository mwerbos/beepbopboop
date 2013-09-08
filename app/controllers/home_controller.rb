class HomeController < ApplicationController
  autocomplete :activity, :name, :full => true
  before_filter :require_user, :except => ['main','search']
  before_filter :setup_new_user_and_session, :only => ['main', 'search']

  def main
    @events = Event.find(:all, :order => "start_time desc", :limit => 5)
    @activities = Activity.find(:all, :order => "id desc", :limit => 5)
    respond_to do |format|
      format.html
    end
  end

  def search
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
