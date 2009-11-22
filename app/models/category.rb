class Category < ActiveRecord::Base
  has_many :posts
  
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  
end
