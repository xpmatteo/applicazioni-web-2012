class QuotesController < ApplicationController
  def index
    @quote = Quote.random
  end
end
