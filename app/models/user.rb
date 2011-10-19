class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :hp, :password, :password_confirmation
  
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
  
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
                       
  before_save :encrypt_password
  
  has_many :wishes, :order => "wishes.created_at DESC",
                    :foreign_key => 'wanter_id',
                    :dependent => :destroy
  
  has_many :items, :foreign_key => 'owner_id',
                   :dependent => :destroy
  
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end



# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  hp                 :string(255)
#  location_id        :integer
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

