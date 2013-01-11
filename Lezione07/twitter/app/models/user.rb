require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :username, :password, :password_confirmation
  
  validates :username, :presence => true, :length => { :minimum => 3 }, :uniqueness => true
  validates :email, :format => /@/
  validates :password, :confirmation => true
  validates :password, :presence => true, :on => :create
  
  before_save :encrypt_password
  
  def to_s
    "@#{username}"
  end
  
  def authenticate(password)
    self.password_digest == Digest::SHA1.hexdigest(password)
  end
  
  def encrypt_password
    if password.present?
      self.password_digest = Digest::SHA1.hexdigest(self.password)
    end
  end
end
