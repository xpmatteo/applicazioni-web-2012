class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:username]
    digest = User.encrypt(params[:password])
    user = User.where("username = :username and password_digest = :digest",
      {:username => username, :digest => digest}).first
    if user
      flash[:notice] = "Bentornato #{user.username}!"
      session[:user_id] = user.id
      redirect_to "/"
    else
      flash[:notice] = "Username o password errata"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end
end
