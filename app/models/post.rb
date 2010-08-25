class Post < ActiveRecord::Base
  
  has_many :images, :as => :uploadable, :dependent => :destroy, :order => 'images.position'
    
  validates_presence_of :title, :body, :category
  validates_uniqueness_of :title
  
  belongs_to :category
  
  acts_as_textiled :body
  acts_as_list :scope => :category_id
  
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
  
  named_scope :most_recent, :order => 'created_at DESC', :limit => '3'  
  named_scope :ordered, :order => :position
  
  state_machine :visibility_state, :initial => :preview do
    event :show do
      transition [:preview, :invisible] => :visible
    end

    event :hide do
      transition :visible => :invisible
    end
  end

  def self.visible
    with_visibility_state(:visible)
  end   

  def self.visibility_states
    state_machines[:visibility_state].states.map(&:value)
  end
  
end
