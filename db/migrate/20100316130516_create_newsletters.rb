class CreateNewsletters < ActiveRecord::Migration
  def self.up
    create_table  :newsletters do |t|
      t.string    :subject
      t.text      :body
      t.datetime  :sent_at
      t.string    :attachment_file_name
      t.string    :attachment_content_type
      t.integer   :attachment_file_size
      t.datetime  :attachment_updated_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :newsletters
  end
end