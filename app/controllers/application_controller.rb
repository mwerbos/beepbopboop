class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user_session, :current_user
  
  private

  def setup_new_user_and_session
    if(!current_user)
      @user = User.new
      @user_session = UserSession.new
    end
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      flash[:notice] = 'You must be logged in to access this page.'
      redirect_to :login
      return false
    end
  end
  
  def require_admin
    puts "******************CURRENT ADMIN STATUS: ", session[:current_admin_status]
    unless admin? == true
      store_location
      redirect_to :admin
    end
  end

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back
    #DEBUG
    puts "**********CURRENT ADMIN STATUS: ", session[:current_admin_status]
    puts "**********LAST PAGE VISITED: ", session[:return_to]
    redirect_to(session[:return_to])
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
  end
  
end
