class CreateWishes < ActiveRecord::Migration
  def self.up
    create_table :wishes do |t|
      t.integer :wanter_id
      t.integer :category_id
      t.integer :item_id

      t.timestamps
    end
    add_index :wishes, :wanter_id
    add_index :wishes, :category_id
    add_index :wishes, :item_id
  end

  def self.down
    drop_table :wishes
  end
end
