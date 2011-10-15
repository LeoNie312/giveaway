class AddConnectedAtToWishes < ActiveRecord::Migration
  def self.up
    add_column :wishes, :connected_at, :datetime
  end
  
  def self.down
    remove_column :wishes, :connected_at
  end
end
