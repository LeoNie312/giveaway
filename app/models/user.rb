class User < ActiveRecord::Base
  attr_accessibe :name, :email, :hp
end

# == Schema Information
#
# Table name: users
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  email       :string(255)
#  hp          :string(255)
#  location_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

