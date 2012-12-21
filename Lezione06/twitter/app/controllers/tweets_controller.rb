class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end
  
  def create
    @tweet = Tweet.new(params[:tweet])
    if @tweet.save
      flash[:notice] = "New tweet!"
    end
    redirect_to :action => "index"
  end
end
