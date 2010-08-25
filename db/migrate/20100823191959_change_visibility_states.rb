class ChangeVisibilityStates < ActiveRecord::Migration
  def self.up
    Post.all.each do |post|
      post.update_attribute :visibility_state, 'visible'
    end
  end

  def self.down
  end
end
