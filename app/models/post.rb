class Post < ActiveRecord::Base
  
  validates_presence_of :title, :body
  validates_uniqueness_of :title
  
  belongs_to :category
  
  #acts_as_textiled :body
  
  has_friendly_id :permalink, :use_slug => true, :strip_diacritics => true
  
  named_scope :most_recent, :order => 'created_at DESC', :limit => '3'
  
  
  def permalink
    self[:permalink] || title
  end
  
end
