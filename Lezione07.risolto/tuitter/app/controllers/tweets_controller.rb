class TweetsController < ApplicationController
  before_filter :authenticate, :only => :create
  before_filter :authorize, :only => :create

  def index
    @tweets = Tweet.order("created_at desc").all
  end
  
  def create
    @tweet = Tweet.new(params[:tweet])
    if @tweet.save
      flash[:notice] = "New tweet!"
    else
      flash[:notice] = "Type something!"
    end
    redirect_to :action => "index"
  end
  
  private
  
  def authorize
    if current_user.id != params[:user_id].to_i
      render :nothing => true, :status => 401
    end
  end
end
