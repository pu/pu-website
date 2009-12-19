class AddTownToKid < ActiveRecord::Migration
  def self.up
    add_column :kids, :town, :string
  end

  def self.down
    remove_column :kids, :town
  end
end
