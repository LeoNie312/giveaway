class UsersLocation < ActiveRecord::Base
  
  validates :user_id, :location_id, :presence => true
  validates :user_id, :uniqueness => true
  
  belongs_to :user
  belongs_to :location
end

# == Schema Information
#
# Table name: users_locations
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  location_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

