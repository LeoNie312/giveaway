class Location < ActiveRecord::Base
  
  has_many :users_locations, :dependent => :destroy
  has_many :users, :through => :users_locations
end

# == Schema Information
#
# Table name: locations
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

