class ChangeDataTypeForPostsPosition < ActiveRecord::Migration
  def self.up
    change_column :posts, :position, :integer
  end

  def self.down
    change_column :posts, :position, :string
  end
end
