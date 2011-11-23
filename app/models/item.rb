class Item < ActiveRecord::Base
  attr_accessible :description, :img_link, :category_id
  
  before_create :calculate_onshelf_time
  
  before_destroy :disconnect_wishes
  
  after_save :ensure_invisibility
  
  link_regex = /^http:\/\/(www.)?[\w+\-]+\.com\//i
  
  validates :description, :length => { :maximum => 100}
  validates :img_link, :length => { :maximum => 100},
                       :format => { :with => link_regex },
                       :allow_blank => true
  validates :category_id, :presence => true
  validates :owner_id, :presence => true
  
  belongs_to :category
  
  belongs_to :owner, :class_name => 'User'
  
  has_many :wishes, :order => 'wishes.connected_at DESC'
  
  default_scope :order => 'items.onshelf_at DESC'
  
  # This method should change owner attribute
  # to new owner, and toggle onshelf attribute,
  # and make onshelf_at nil.
  # BTW, run wish.disconnect! on every wish connected
  # to it, and destroy the successful wish. 
  # Quite a bit of work :-)
  
  def transfer!(receiver)
    raise "receiver is owner!" if owner == receiver
    self.owner = receiver
    self.onshelf_at = nil
    self.onshelf = false
    
    wishes.each do |wish|
      unless wish.wanter == receiver
        wish.disconnect!
      else
        wish.destroy
      end
    end
    
    self.save!
  end
  
  
  # This method should toggle onshelf attribute,
  # and calculate onshelf_at time
  
  def re_onshelf
    self.onshelf = true
    self.onshelf_at = DateTime.now
    self.save
  end
  
  private
    def calculate_onshelf_time
      self.onshelf_at = DateTime.now
    end
    
    def disconnect_wishes
      wishes.each do |wish|
        wish.disconnect!
      end
    end
    
    def ensure_invisibility
      if !onshelf? and wishes.any? and !onshelf_at.nil?
        raise "The offshelf item has wishes associated with it remain, 
                or onshelf_at attribute isn't nil"
      end
    end
end


# == Schema Information
#
# Table name: items
#
#  id          :integer         not null, primary key
#  description :string(255)
#  img_link    :string(255)
#  category_id :integer
#  onshelf     :boolean         default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime
#  onshelf_at  :datetime
#  owner_id    :integer
#

