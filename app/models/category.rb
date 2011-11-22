class Category < ActiveRecord::Base
  has_many :items, :conditions => '(items.onshelf_at IS NOT NULL)'
  
  # once a wish is connected to an item, 
  # it will no longer be retrieved by using
  # category.wishes. 
  # So that this wish is entering 'pending' 
  # state, and is only visible to that item's owner
  has_many :wishes, :order => "wishes.created_at DESC",
                    :conditions => '(wishes.item_id IS NULL)'
                  
  has_many :categories_connections, :foreign_key => 'parent_id'
  
  has_many :children, :through => :categories_connections
  
  has_one :reverse_categories_connection, :class_name => 'CategoriesConnection',
                              :foreign_key => 'child_id'
                              
  has_one :parent, :through => :reverse_categories_connection
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

