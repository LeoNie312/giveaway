require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => "Example User", 
              :email => "user@e.ntu.edu.sg",
              :hp => "12345678",
              :password => "foobar",
              :password_confirmation => "foobar"
              }
  end
  
  describe "Name, email and hp validations" do
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
  
    it "should reject non-numerical handphone inputs or handphone numbers with more than 8 digits" do
      numbers = ["1234 678", "+65123456", "q2345678", "1234567", "123456789"]
      numbers.each do |number|
        invalid_hp_user = User.new(@attr.merge(:hp => number))
        invalid_hp_user.should_not be_valid
      end
    end
  end
  
  describe "password validations" do
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
  
  describe "association" do
    
    describe "with wishes" do
      before :each do
        @user = User.create(@attr)
        @wish1 = Factory(:wish, :wanter=>@user, :category_id => 1, :created_at=>1.day.ago)
        @wish2 = Factory(:wish, :wanter=>@user,:category_id => 1, :created_at=>1.hour.ago)
      end
    
      it "should have a 'wishes' method" do
        @user.should respond_to(:wishes)
      end
    
      it "should have the right wishes in the right order" do
        @user.wishes.should == [@wish2, @wish1]
      end
      
      it "should destroy associated wishes" do
        @user.destroy
        [@wish1, @wish2].each do |w|
          Wish.find_by_id(w.id).should be_nil
        end
      end
    end
    
    describe "with items" do
      
      before :each do
        @user = User.create(@attr)
        @item1 = Factory(:item, :owner=>@user)
        sleep(1)
        @item2 = Factory(:item, :owner=>@user)        
      end
      
      it "should have a items method" do
        @user.should respond_to(:items)
      end
      
      it "should have the right items in the right order" do
        @user.items.should == [@item2, @item1]
      end
      
      it "should destroy associated items" do
        @user.destroy
        [@item1, @item2].each do |i|
          Item.find_by_id(i.id).should be_nil
        end
      end
    end
  end
  
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end
    
    describe "authenticate method" do
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end
      
      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("nonexist@ntu.edu.sg", @attr[:password])
        nonexistent_user.should be_nil
      end
      
      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
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

