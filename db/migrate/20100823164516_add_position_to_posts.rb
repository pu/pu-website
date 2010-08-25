class AddPositionToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :position, :string
  end

  def self.down
    remove_column :posts, :position
  end
end
