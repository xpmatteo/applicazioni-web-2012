class Tweet
  attr_accessor :text
  attr_reader :id, :errors
  
  @@tweets = []  

  def Tweet.all
    @@tweets
  end
  
  def Tweet.delete_all
    @@tweets = []
  end
  
  def Tweet.find(id)
    @@tweets.find { |tweet| tweet.id == id.to_i }
  end
  
  def initialize(params={})
    @text = params[:text]
    @created_at = Time.now
  end
  
  def save
    if valid?
      @@tweets << self
      @id = @@tweets.size
      return true
    end
    false
  end
  
  def valid?
    validate
    errors.empty?
  end
  
  def validate
    @errors = []
  end
end

Tweet.new(:text => "Ciao!").save
Tweet.new(:text => "Sono a laboratorio di App Web").save
Tweet.new(:text => "Goodbye").save
