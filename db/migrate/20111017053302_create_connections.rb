class CreateConnections < ActiveRecord::Migration
  def self.up
    create_table :connections do |t|
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
    add_index :connections, :parent_id
    add_index :connections, :child_id, :unique => true
  end
  
  def self.down
    drop_table :connections
  end
end
