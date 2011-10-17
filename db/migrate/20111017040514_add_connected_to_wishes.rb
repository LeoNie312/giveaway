class AddConnectedToWishes < ActiveRecord::Migration
  def self.up
    add_column :wishes, :connected, :boolean, :default => false
  end
  
  def self.down
    remove_column :wishes, :connected
  end
end
