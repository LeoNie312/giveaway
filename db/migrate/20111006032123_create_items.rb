class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :description
      t.string :img_link
      t.integer :category_id
      t.boolean :onshelf, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
