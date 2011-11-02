class UsersLocation < ActiveRecord::Base
  
  validates :user_id, :location_id, :presence => true
  validates :user_id, :uniqueness => true
  
  belongs_to :user
  belongs_to :location
end
