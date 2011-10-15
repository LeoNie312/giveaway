class Wish < ActiveRecord::Base
  attr_accessible :category_id, :item_id
  
  validates :category_id, :presence => true
  
  validates :wanter_id, :presence => true
  
  belongs_to :wanter, :class_name => "User"
  
  belongs_to :item
  
  default_scope :order => "wishes.created_at DESC"
  
  def connect item
    self.connected_at = DateTime.now
    self.item_id = item.id
    self.save
  end
end
