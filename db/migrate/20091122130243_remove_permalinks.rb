class RemovePermalinks < ActiveRecord::Migration
  def self.up
    remove_column :posts, :permalink
    remove_column :pages, :permalink
  end

  def self.down
    add_column :posts, :permalink, :string
    add_column :pages, :permalink, :string
  end
end
