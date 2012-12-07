require "minitest/autorun"

require_relative "../../app/models/tweet"

class TweetTest < MiniTest::Unit::TestCase
  def setup
    Tweet.delete_all
    @tweet = Tweet.new :text => "foo", :author_id => 2
  end
  
  def test_create
    assert_equal "foo", @tweet.text
  end

  def test_save
    assert @tweet.save, "sav"
    assert_equal 1, Tweet.all.count
    assert_equal 1, Tweet.all.first.id
  end
  
  def test_find
    assert_nil Tweet.find(1)
    assert @tweet.save, "saved ok"
    assert_equal @tweet, Tweet.find(1)
  end
end