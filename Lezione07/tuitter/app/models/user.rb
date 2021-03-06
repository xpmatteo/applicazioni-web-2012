require 'digest/sha2'

class User < ActiveRecord::Base
  before_save :encrypt_password
  
  attr_accessor :password
  
  attr_accessible :email, :username, :password, :password_confirmation
  validates :username, :presence => true, :length => { :minimum => 3 }
  validates :email, :format => /@/
  validates :password, :confirmation => true
  
  def authenticate(password)
    encrypt(password) == self.password_digest
  end
  
  def encrypt_password
    self.password_digest = encrypt(password)
  end
  
  def encrypt(password)
    Digest::SHA2.hexdigest(password)
  end
  
  def to_s
    "@#{username}"
  end
end
