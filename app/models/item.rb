class Item < ActiveRecord::Base
  attr_accessible :description, :img_link
  
  link_regex = /^http:\/\/(www.)?[\w+\-]+\.com\//i
  
  validates :description, :length => { :maximum => 100}
  validates :img_link, :length => { :maximum => 100},
                       :format => { :with => link_regex }
  validates :category_id, :presence => true
  
  belongs_to :category
end
