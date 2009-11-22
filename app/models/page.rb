class Page < ActiveRecord::Base
    
  validates_presence_of :title, :body
  validates_uniqueness_of :title
  
  acts_as_textiled :body
  
  has_friendly_id :title, :use_slug => true, :strip_diacritics => true
  
end