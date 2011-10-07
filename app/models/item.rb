class Item < ActiveRecord::Base
  attr_accessible :description, :img_link
  
  before_save :calculate_onshelf_time
  
  link_regex = /^http:\/\/(www.)?[\w+\-]+\.com\//i
  
  validates :description, :length => { :maximum => 100}
  validates :img_link, :length => { :maximum => 100},
                       :format => { :with => link_regex }
  validates :category_id, :presence => true
  
  belongs_to :category
  
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
