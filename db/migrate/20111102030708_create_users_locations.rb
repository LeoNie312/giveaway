class CreateUsersLocations < ActiveRecord::Migration
  def change
    create_table :users_locations do |t|
      t.integer :user_id
      t.integer :location_id

      t.timestamps
    end
  end
end
