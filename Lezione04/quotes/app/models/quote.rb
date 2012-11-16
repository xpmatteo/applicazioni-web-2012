class Quote
  ALL_QUOTES = File.read("#{Rails.root}/db/quotes.txt").split("%")

  attr_reader :id, :text  
  
  def initialize(id, text)
    @id = id
    @text = text    
  end
  
  def Quote.find(id)
    Quote.new(id, ALL_QUOTES[id])
  end
  
  def Quote.random
    Quote.find(rand(ALL_QUOTES.size))
  end
end
