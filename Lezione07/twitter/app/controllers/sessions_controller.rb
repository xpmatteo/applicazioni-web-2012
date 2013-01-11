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
end
