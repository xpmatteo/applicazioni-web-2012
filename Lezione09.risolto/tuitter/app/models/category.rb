class Category < ActiveRecord::Base
  attr_accessible :name
  
  def to_s
    self.name
  end
  
  def Category.find_or_create_by_name(name)
    category = Category.find_by_name(name)
    if !category
      category = Category.create!(:name => name)
    end
  end
  
  def find_by_name(name)
    Category.where("name = ?", name).first
  end
end
