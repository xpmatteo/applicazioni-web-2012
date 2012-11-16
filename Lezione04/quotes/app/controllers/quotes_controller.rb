class QuotesController < ApplicationController
  def index
    @quote = Quote.random
  end

  def random
  end
end
