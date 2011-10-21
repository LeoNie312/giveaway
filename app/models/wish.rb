class Wish < ActiveRecord::Base
  attr_accessible :category_id, :item_id
  
  validates :category_id, :presence => true
  
  validates :wanter_id, :presence => true
  
  belongs_to :wanter, :class_name => "User"
  
  belongs_to :item
  
  belongs_to :category
  
  # default_scope :order => "wishes.created_at DESC"
  
  def connect item
    # if a user accidentally wants an item 
    # which is posted by oneself, or
    # the wish is still connecting to an item,
    # the 'connect' method will return false
    unless item.owner == wanter || self.item != nil
      self.connected_at = DateTime.now
      self.item_id = item.id
      self.connected = true
      self.save
    end
  end
  
  def disconnect!
    self.item_id = nil
    self.connected_at = nil
    self.connected = false
    self.save!
  end
end
