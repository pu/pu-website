class Page < ActiveRecord::Base
    
  validates_presence_of :title, :body
  validates_uniqueness_of :title
  
  acts_as_textiled :body
  
  has_friendly_id :seo_title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
  
end