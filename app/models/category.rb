class Category < ActiveRecord::Base
  has_many :items
  
  has_many :wishes
end

# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

