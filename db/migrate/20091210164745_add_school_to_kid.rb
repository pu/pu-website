class AddSchoolToKid < ActiveRecord::Migration
  def self.up
    add_column :kids, :school_id, :integer
  end

  def self.down
    remove_column :kids, :school_id
  end
end
