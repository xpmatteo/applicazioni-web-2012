class TweetsController < ApplicationController
  before_filter :authenticate, :only => :create

  def index
    @tweets = Tweet.includes("user").order("created_at desc").all
  end
  
  def create    
    @tweet = current_user.tweets.build(params[:tweet])
    if @tweet.save
      flash[:notice] = "New tweet!"
    else
      flash[:notice] = "Type something!"
    end
    redirect_to :action => "index"
  end
end
