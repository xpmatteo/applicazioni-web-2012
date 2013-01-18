class User < ActiveRecord::Base
  attr_accessible :email, :username
  validates :username, :presence => true, :length => { :minimum => 3 }
  validates :email, :format => /@/
  
  def to_s
    "@#{username}"
  end
end
