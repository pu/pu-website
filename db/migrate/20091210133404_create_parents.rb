class CreateParents < ActiveRecord::Migration
  def self.up
    create_table :parents do |t|
      t.string :name
      t.string :firstname
      t.string :street
      t.string :zip_code
      t.string :town
      t.string :email
      t.timestamps
    end
  end
  
  def self.down
    drop_table :parents
  end
end
