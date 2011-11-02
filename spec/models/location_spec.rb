require 'spec_helper'

describe Location do

  before :each do
    @location = Location.create(name: "LWN Library")
  end
  
  describe "users_location association" do
    
    before :each do
      @user1 = Factory(:user )
      @user2 = Factory(:user, name: Factory.next(:name),
                  email: Factory.next(:email))
      @userslocation1 = Factory(:users_location, user_id: @user1.id,
                          location_id: @location.id)
      @userslocation2 = Factory(:users_location, user_id: @user2.id,
                          location_id: @location.id)
    end
    
    it "should have a users_locations method" do
      @location.should respond_to(:users_locations)
    end
    
    it "should have a users method" do
      @location.should respond_to(:users)      
    end
    
    it "should have the right users set" do
      @location.users.to_set.should == [@user1, @user2].to_set
    end
  end
end
