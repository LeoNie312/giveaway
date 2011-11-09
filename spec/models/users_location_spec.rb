require 'spec_helper'

describe UsersLocation do

  before :each do
    @user = Factory(:user)
    @location = Factory(:location, name: "LWN Library")
  end

  describe "validation" do
    
    it "should require user_id" do
      UsersLocation.new(location_id: @location.id)
        .should_not be_valid
    end
    
    it "should require location_id" do
      UsersLocation.new(user_id: @user.id)
        .should_not be_valid
    end
    
    it "should require a unique user_id" do
      UsersLocation.create!(location_id: @location.id,
                  user_id: @user.id)
      other_location = Factory(:location, name: "NBS")
      UsersLocation.new(location_id: other_location.id,
                  user_id: @user.id).should_not be_valid
    end
  end
  
  describe "association" do
    
    before :each do
      @userslocation = UsersLocation.create!(
                  location_id: @location.id,
                  user_id: @user.id)
    end
    
    it "should have a user method" do
      @userslocation.should respond_to(:user)
    end
    
    it "should be the correct user" do
      @userslocation.user.should == @user
      @userslocation.user_id.should == @user.id
    end
    
    it "should have a location method" do
      @userslocation.should respond_to(:location)
    end
    
    it "should be the correct location" do
      @userslocation.location.should == @location
      @userslocation.location_id.should == @location.id
    end
    
    describe "of dependency on both user and location" do
      
      it "should destroy at user's destroy" do
        @user.destroy
        UsersLocation.find_by_id(@userslocation.id)
            .should be_nil
      end
      
      it "should destroy at location's destroy" do
        another_user = Factory(:user, name: Factory.next(:name),
                                  email: Factory.next(:email))
        UsersLocation.create(user_id: another_user.id,
                  location_id: @location.id)
        
        location_id = @location.id          
        @location.destroy
        UsersLocation.find_by_location_id(location_id)
            .should be_nil
        
        @user.location.should be_nil
      end
    end
  end
end

# == Schema Information
#
# Table name: users_locations
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  location_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

