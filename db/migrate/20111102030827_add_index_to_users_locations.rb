class AddIndexToUsersLocations < ActiveRecord::Migration
  def change
    add_index :users_locations, :user_id, :unique => true
    add_index :users_locations, :location_id
  end
end
