class Wish < ActiveRecord::Base
  attr_accessible :category_id, :item_id
  
  belongs_to :wanter, :class_name => "User"
end
