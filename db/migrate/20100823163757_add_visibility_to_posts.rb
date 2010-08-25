class AddVisibilityToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :visibility_state, :string
  end

  def self.down
    remove_column :posts, :visibility_state
  end
end
