class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Grazie per esserti registrato!"
      redirect_to :action => "show", :id => @user.id
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])  
    @user.update_attributes(params[:user])  
    redirect_to :action => "show", :id => @user.id
  end
end
