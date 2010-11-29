class RemoveSchoolIdFromKids < ActiveRecord::Migration
  def self.up
    remove_column :kids, :school_id
  end

  def self.down
    add_column :kids, :school_id, :integer
  end
end
