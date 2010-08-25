class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images, :force => true do |t|
      t.string :data_file_name
      
      t.string :data_content_type 
      t.integer :data_file_size
      t.integer :uploadable_id 
      
      t.string :uploadable_type
      t.string :status 
      t.integer :position
      
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
