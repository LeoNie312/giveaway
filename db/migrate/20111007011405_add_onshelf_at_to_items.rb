class AddOnshelfAtToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :onshelf_at, :datetime
  end

  def self.down
    remove_column :items, :onshelf_at
  end
end
