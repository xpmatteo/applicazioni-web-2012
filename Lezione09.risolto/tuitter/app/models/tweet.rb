class Tweet < ActiveRecord::Base
  attr_accessible :text, :user_id, :category_id
  validates :text, :presence => true

  belongs_to :user
  belongs_to :category
end
