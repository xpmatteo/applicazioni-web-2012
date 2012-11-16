class ApplicationController < ActionController::Base
  before_filter :count_quotes
  
  def count_quotes
    @quotes_count = Quote::ALL_QUOTES.count
  end
end
