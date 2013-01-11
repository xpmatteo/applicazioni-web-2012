class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order("created_at desc").all
    @users = User.all
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
end
