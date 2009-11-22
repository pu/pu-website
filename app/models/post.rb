class Post < ActiveRecord::Base
    
  validates_presence_of :title, :body, :category
  validates_uniqueness_of :title
  
  belongs_to :category
  
  acts_as_textiled :body
  
  has_friendly_id :title, :use_slug => true, :strip_diacritics => true
  
  named_scope :most_recent, :order => 'created_at DESC', :limit => '3'
  
end
