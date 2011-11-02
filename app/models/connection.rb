class Connection < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Category'
  belongs_to :child, :class_name => 'Category'
  
  validates :parent_id, :presence => true
  validates :child_id, :presence => true
end

# == Schema Information
#
# Table name: connections
#
#  id         :integer         not null, primary key
#  parent_id  :integer
#  child_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

