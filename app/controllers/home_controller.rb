class HomeController < ApplicationController
  before_filter :require_user, :except => ['main']
  def main
    @user = User.new
    @user_session = UserSession.new
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
