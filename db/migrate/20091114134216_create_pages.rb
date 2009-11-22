class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :permalink
      t.text :body

      t.timestamps
    end
    
    add_index :pages, :title
    add_index :pages, :permalink
  end

  def self.down
    drop_table :pages
  end
end
