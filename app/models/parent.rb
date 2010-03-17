class Parent < ActiveRecord::Base
  attr_accessible :name, :firstname, :street, :zip_code, :town, :email, :phone
  
  has_many :parentships
  has_many :kids, :through => :parentships
  
end
