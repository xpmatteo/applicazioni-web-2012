class User < ActiveRecord::Base
  attr_accessible :email, :username
  
  def to_s
    "@#{username}"
  end
end
