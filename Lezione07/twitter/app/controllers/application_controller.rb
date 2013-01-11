class ApplicationController < ActionController::Base
  helper_method :current_user
  
  private
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      nil
    end
  end
end
