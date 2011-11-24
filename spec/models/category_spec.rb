require 'spec_helper'

describe Category do
  
  before :each do
    @drink = drink_cate
  end

  describe "item association" do

    before :each do
      @item1 = Factory(:item, :owner_id => 1,:category_id=>@drink.id)
      @item1.onshelf_at = 2.days.ago
      @item1.save
      @item2 = Factory(:item, :owner_id => 2, :category_id => @drink.id)
      @item2.onshelf_at = 1.day.ago
      @item2.save
    end
    
    it "should has an item association" do
      @drink.should respond_to(:items)
    end
    
    it "should have the right items in the right order, at items' creation" do
      @drink.items.should == [@item2, @item1]
    end
    
    it "should not include offshelf item" do
      @item1.onshelf_at = nil
      @item1.onshelf = false
      @item1.save!
      @drink.reload
      @drink.items.should_not include(@item1)
    end

  end
  
  describe "wish association" do
    
    before :each do
      @user1 = Factory(:user)
      @user2 = Factory(:user, :email=>Factory.next(:email), :name=>Factory.next(:name))
      @wish1 = Factory(:wish, :category=>@drink, :wanter=>@user1, :created_at=>1.day.ago)
      @wish2 = Factory(:wish, :category=>@drink, :wanter=>@user2, :created_at=>1.hour.ago)
    end
    
    it "should have a wishes method" do
      @drink.should respond_to(:wishes)
    end
    
    it "should have the right wishes in the right order" do
      @drink.wishes.should == [@wish2, @wish1]
    end
    
    it "should not include wish that is connected to a specific item" do
      an_item = Factory(:item, :owner=>@user2)
      @wish1.connect(an_item)
      @drink.wishes.should_not include(@wish1)
      @drink.wishes.should include(@wish2)
    end
    
    # do
    #   an_user = Factory(:user, :email=>Factory.next(:email), :name=>Factory.next(:name))
    #   item = Factory(:item, :owner=>an_user)
    #   @wish1.connect(item)
    #   @drink.wishes.should_not include(@wish1)
    # end
  end
  
  describe "categories_connection association" do
    
    before :each do
      @base = base_cate
      @stationery = Category.find_by_name("stationery")
    end
    
    it "should have a connection method" do
      @drink.should respond_to(:categories_connections)
    end
    
    it "should have a children method" do
      @drink.should respond_to(:children)
    end
    
    it "should have a parent method" do
      @base.should respond_to(:parent)
    end
    
    it "should have the right parent" do
      @drink.parent.should == @base
      @drink.parent.id.should == @base.id
    end
    
    it "should return nil for parent that doesn't exist (base case)" do
      @base.parent.should be_nil
    end
  end
  
end

# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

