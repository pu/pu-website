class Parent < ActiveRecord::Base
  attr_accessible :name, :firstname, :street, :zip_code, :town, :email
  
  has_many :parentships, :dependent => :destroy  
  has_many :kids, :through => :parentships
  
end
