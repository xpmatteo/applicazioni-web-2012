class Tweet < ActiveRecord::Base
  attr_accessible :text, :user_id
  validates :text, :presence => true
  
  def user
    User.find(self.user_id)
  end
end
