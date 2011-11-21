require 'spec_helper'

describe Wish do
  
  before :each do
    @drink = Category.find_by_name("drink")
    @wanter = Factory(:user)
    @attr = {
      :category_id => @drink.id
    }
    @wish = @wanter.wishes.build(@attr)
  end
  
  it "should create a new instance given valid attributes" do 
    @wish.save!
  end
  
  describe "validation" do
    
    it "should require category id" do
      invalid_wish = @wish.dup
      invalid_wish.category_id = nil
      invalid_wish.should_not be_valid
    end
    
    it "should require wanter id" do
      Wish.new(@attr.merge(:wanter_id=>@wanter.id)).should_not be_valid
    end
    
  end
  
  describe "association" do
    
    before :each do
      @wish.save
    end
    
    describe "with wanter" do
      
      it "should have a wanter method" do
        @wish.should respond_to(:wanter)
      end
      
      it "should have the right associated wanter" do
        @wish.wanter.should == @wanter
        @wish.wanter_id.should == @wanter.id
      end
    end
    
    describe "with category" do
      it "should have a category method" do
        @wish.should respond_to(:category)
      end
      
      it "should associate to the right category" do
        @wish.category.should == @drink
        @wish.category_id.should == @drink.id
      end
    end
    
    describe "with item" do
      
      before :each do
        another_user = Factory(:user, :email => Factory.next(:email),
                              :name => Factory.next(:name))
        @item = Factory(:item, :owner=>another_user)
      end
      
      it "should have an item method" do
        @wish.should respond_to(:item)
      end
      
      it "should require connection time when connected to an item" do
        @item.id.should_not be_nil
        @wish.connected_at.should be_nil
        @wish.item_id.should be_nil
        @wish.connect(@item)
        @wish.connected_at.should_not be_nil  
        @wish.item_id.should_not be_nil  
        @wish.should be_connected    
      end
      
      it "should not connect to an item belongs to the same user" do
        item = Factory(:item, :owner=>@wanter)
        @wish.connect(item).should be_false
      end
      
      describe "after connecting to an item" do
      
        before :each do
          @wish.connect(@item)
        end
      
        it "should have the right item" do 
          @wish.item.should == @item
          @wish.item_id.should == @item.id
        end
      
        it "should not be connected to the wanter's item" do
          @wish.item.owner.should_not == @wanter
          @wish.item.owner_id.should_not == @wanter.id
        end
        
        it "should not connect to another item when is still connected to original one" do
          another_user = Factory(:user, :email=>Factory.next(:email),
                                  :name=>Factory.next(:name))
          another_item = Factory(:item, :owner=>another_user)
          @wish.connect(another_item).should be_false
        end
        
        it "should be able to disconnect from the item" do
          @wish.disconnect!
          @wish.item_id.should be_nil
          @wish.connected_at.should be_nil
          @wish.should_not be_connected
        end
        
        it "should disconnect from the item when it timed-out or wish denied"
      end

    end
  end
end

# == Schema Information
#
# Table name: wishes
#
#  id           :integer         not null, primary key
#  wanter_id    :integer
#  category_id  :integer
#  item_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  connected_at :datetime
#  connected    :boolean         default(FALSE)
#

