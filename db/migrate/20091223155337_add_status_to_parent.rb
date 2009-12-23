class AddStatusToParent < ActiveRecord::Migration
  def self.up
    add_column :parents, :status, :string
  end

  def self.down
    remove_column :parents, :status
  end
end
