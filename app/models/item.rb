class Item < ActiveRecord::Base
  attr_accessible :description, :img_link, :category_id
  
  before_save :calculate_onshelf_time
  
  link_regex = /^http:\/\/(www.)?[\w+\-]+\.com\//i
  
  validates :description, :length => { :maximum => 100}
  validates :img_link, :length => { :maximum => 100},
                       :format => { :with => link_regex }
  validates :category_id, :presence => true
  validates :owner_id, :presence => true
  
  belongs_to :category
  
  belongs_to :owner, :class_name => 'User'
  
  has_many :wishes
  
  default_scope :order => 'items.onshelf_at DESC'
  
  
  private
    def calculate_onshelf_time
      # if it is saved the first time, then record;
      # or if not, but onshelf is set to true, 
      # that means the owner decided to re-onshelf
      # the item, then record
      if new_record? || self.onshelf
        self.onshelf_at = DateTime.now
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
#

