class Quote
  attr_reader :text, :id
  
  def initialize(id, text)
    @id = id
    @text = text    
  end
  
  def Quote.random
    all_quotes = File.read("db/quotes.txt").split("%")
    index = rand(all_quotes.size)
    Quote.new(index, all_quotes[index].strip)
  end
end
