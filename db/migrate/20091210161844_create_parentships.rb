class CreateParentships < ActiveRecord::Migration
  def self.up
    create_table :parentships do |t|
      t.integer :kid_id
      t.integer :parent_id
      t.date :expires_at
      t.date :starts_at
      t.string :fee
      t.string :paying_period
      t.timestamps
    end
  end
  
  def self.down
    drop_table :parentships
  end
end
