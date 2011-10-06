require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => "Example User", 
              :email => "user@e.ntu.edu.sg",
              :hp => "12345678" }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should require a handphone number" do
    no_hp_user = User.new(@attr.merge(:hp => ""))
    no_hp_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept 'ntu.edu.sg' or 'e.ntu.edu.sg' email addresses" do
    addresses = %w[user@ntu.edu.sg THE_USER@ntu.edu.sg first.last@ntu.edu.sg 
                   user@e.ntu.edu.sg THE_USER@e.ntu.edu.sg first.last@e.ntu.edu.sg]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject email addresses not ending with 'ntu.edu.sg' or 'e.ntu.edu.sg'" do
    addresses = %w[bertil@ntu.edu.org ANDERSSON@ntu.edu user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr.merge(:name => "Another User"))
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    User.create!(@attr)
    upcased_email = @attr[:email].upcase
    user_with_duplicate_email = User.new(@attr.merge(:name => "Another User", :email => upcased_email))
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject duplicate names" do
    User.create!(@attr)
    user_with_duplicate_name = User.new(@attr.merge(:email => "foo@e.ntu.edu.sg"))
    user_with_duplicate_name.should_not be_valid
  end

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

