require 'digest/sha1'

class SessionsController < ApplicationController
  
  def create
    user = User.where(["username = ?", params[:username]]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.username}!"
      redirect_to "/"
    else
      flash[:notice] = "Bad username or password"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully"
    redirect_to "/"
  end
end
