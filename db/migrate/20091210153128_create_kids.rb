class CreateKids < ActiveRecord::Migration
  def self.up
    create_table :kids do |t|
      t.string :name
      t.string :firstname
      t.datetime :birthday
      t.text :description
      t.integer :number
      t.datetime :sponsored_until
      t.timestamps
    end
  end
  
  def self.down
    drop_table :kids
  end
end
