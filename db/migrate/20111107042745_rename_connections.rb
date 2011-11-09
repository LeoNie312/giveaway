class RenameConnections < ActiveRecord::Migration
  def up
    rename_table :connections, :categories_connections
  end

  def down
    rename_table :categories_connections, :connections
  end
end
