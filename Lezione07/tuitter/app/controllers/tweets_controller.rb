class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order("created_at desc").all
  end
  
  def create
    raise "non ci casco" if current_user.nil?
    @tweet = Tweet.new(params[:tweet])
    if @tweet.save
      flash[:notice] = "New tweet!"
    else
      flash[:notice] = "Type something!"
    end
    redirect_to :action => "index"
  end
end
