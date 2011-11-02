class Location < ActiveRecord::Base
  
  has_many :users_locations, :dependent => :destroy
  has_many :users, :through => :users_locations
end
