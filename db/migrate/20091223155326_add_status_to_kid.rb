class AddStatusToKid < ActiveRecord::Migration
  def self.up
    add_column :kids, :status, :string
  end

  def self.down
    remove_column :kids, :status
  end
end
