require 'spec_helper'

describe Category do
  
  before :each do
    @category = Category.create({:name => "base"})
  end

  describe "item association" do

    before :each do
      @item1 = Factory(:item, :owner_id => 1,:category_id=>@category.id)
      sleep(1)
      @item2 = Factory(:item, :owner_id => 2, :category_id => @category.id)
    end
    
    it "should has an item association" do
      @category.should respond_to(:items)
    end
    
    it "should have the right items in the right order, at items' creation" do
      @category.items.should == [@item2, @item1]
    end
    
    it "should have the right items in the right order, when one item is re-onshelved"

  end
  
  describe "wish association" do
    
    before :each do
      @user1 = Factory(:user)
      @user2 = Factory(:user, :email=>Factory.next(:email), :name=>Factory.next(:name))
      @wish1 = Factory(:wish, :category=>@category, :wanter=>@user1, :created_at=>1.day.ago)
      @wish2 = Factory(:wish, :category=>@category, :wanter=>@user2, :created_at=>1.hour.ago)
    end
    
    it "should have a wishes method" do
      @category.should respond_to(:wishes)
    end
    
    it "should have the right wishes in the right order" do
      @category.wishes.should == [@wish2, @wish1]
    end
    
    it "should not include wish that is connected to a specific item" do
      an_item = Factory(:item, :owner=>@user2)
      @wish1.connect(an_item)
      @category.wishes.should_not include(@wish1)
      @category.wishes.should include(@wish2)
    end
    
    # do
    #   an_user = Factory(:user, :email=>Factory.next(:email), :name=>Factory.next(:name))
    #   item = Factory(:item, :owner=>an_user)
    #   @wish1.connect(item)
    #   @category.wishes.should_not include(@wish1)
    # end
  end
  
  describe "connection association" do
    
    before :each do
      @child_cate1 = Category.create(:name=>"drink")
      @child_cate2 = Category.create(:name=>"stationery")
      @connection1 = Factory(:connection, :parent_id=>@category.id, :child_id=>@child_cate1.id)
      @connection2 = Factory(:connection, :parent_id=>@category.id, :child_id=>@child_cate2.id)
    end
    
    it "should have a connection method" do
      @category.should respond_to(:connections)
    end
    
    it "should have a children method" do
      @category.should respond_to(:children)
    end
    
    it "should have the right children" do
      @category.children.should == [@child_cate1, @child_cate2]
    end
    
    it "should have a parent method" do
      @child_cate1.should respond_to(:parent)
    end
    
    it "should have the right parent" do
      @child_cate1.parent.should == @category
      @child_cate1.parent.id.should == @category.id
    end
    
    it "should return nil for parent that doesn't exist (base case)" do
      @category.parent.should be_nil
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

