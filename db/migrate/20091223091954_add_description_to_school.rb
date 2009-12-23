class AddDescriptionToSchool < ActiveRecord::Migration
  def self.up
    add_column :schools, :description, :text
  end

  def self.down
    remove_column :schools, :description
  end
end
