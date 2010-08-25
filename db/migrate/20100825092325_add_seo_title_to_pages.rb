class AddSeoTitleToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :seo_title, :string
  end

  def self.down
    remove_column :pages, :seo_title
  end
end
