class User < ActiveRecord::Base
  attr_accessible :name, :email, :hp
  
  ntu_email_regex = /\A[\w+\-.]+@(e\.)?ntu\.edu\.sg/i
  hp_regex = /\A\d{8}\z/
  
  validates :name, :presence   => true,
                   :length     => { :maximum => 50 },
                   :uniqueness => true  # But do we really need unique username?
                   
  validates :email, :presence   => true,
                    :format     => { :with => ntu_email_regex },
                    :uniqueness => { :case_sensitive => false }
                    
  validates :hp, :presence => true,
                 :format   => { :with => hp_regex }
                 
  has_many :wishes, :foreign_key => 'wanter_id',
                    :dependent => :destroy
  
  has_many :items, :foreign_key => 'owner_id',
                   :dependent => :destroy
  
end

# == Schema Information
#
# Table name: users
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  email       :string(255)
#  hp          :string(255)
#  location_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

