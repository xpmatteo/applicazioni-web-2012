require 'digest/sha1'

class SessionsController < ApplicationController
  
  def create
    digest = Digest::SHA1.hexdigest(params[:password])
    user = User.where(["username = ? and password_digest = ?", params[:username], digest]).first
    if user
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.username}!"
      redirect_to "/"
    else
      flash[:notice] = "Bad username or password"
      render "new"
    end
  end
end
