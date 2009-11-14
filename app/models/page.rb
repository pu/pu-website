class Page < ActiveRecord::Base
  
  validates_presence_of :title, :body
  validates_uniqueness_of :title
  
  # friendly_id ?
  # status?
    
end