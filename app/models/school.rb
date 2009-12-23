class School < ActiveRecord::Base
  attr_accessible :name
  
  has_many :kids, :through => :school_visits
  has_many :school_visits
end
