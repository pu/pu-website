class CreateLettersWrittens < ActiveRecord::Migration
  def self.up
    create_table :letters_writtens do |t|
      t.integer :kid_id
      t.integer :letter_id
      t.boolean :received

      t.timestamps
    end
  end

  def self.down
    drop_table :letters_writtens
  end
end
