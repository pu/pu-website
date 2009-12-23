class CreateSchoolVisits < ActiveRecord::Migration
  def self.up
    create_table :school_visits do |t|
      t.integer :kid_id
      t.integer :school_id
      t.string :grade
      t.boolean :boarding
      t.text :description

      t.timestamps
    end
  end

  def self.down
     drop_table :school_visits
  end
end
