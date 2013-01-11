class CounterController < ApplicationController
  def index    
    @counter = session[:counter] || 0
    session[:counter] = @counter.to_i + 1
  end
end
