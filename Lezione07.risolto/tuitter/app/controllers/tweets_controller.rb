class TweetsController < ApplicationController
  before_filter :authenticate, :only => :create
  before_filter :authorize_tweet_update, :only => :create

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
  
  def authorize_tweet_update
    if current_user.id != params[:tweet][:user_id].to_i
      render :nothing => true, :status => 401
    end
  end
end
