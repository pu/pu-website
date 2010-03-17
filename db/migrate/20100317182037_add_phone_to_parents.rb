class AddPhoneToParents < ActiveRecord::Migration
  def self.up
    add_column :parents, :phone, :string
  end

  def self.down
    remove_column :parents, :phone
  end
end
