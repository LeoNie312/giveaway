class AddOwnerIdToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :owner_id, :integer
    add_index :items, :owner_id
    add_index :items, :category_id
  end

  def self.down
    remove_column :items, :owner_id
  end
end
