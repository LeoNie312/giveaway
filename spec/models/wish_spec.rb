require 'spec_helper'

describe Wish do
  
  before :each do
    @category = Factory(:category)
    @wanter = Factory(:user)
    @attr = {
      :category_id => 1
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
      Wish.new(@attr.merge(:wanter_id=>1)).should_not be_valid
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
      pending "when don't let browsing users see wishes, don't implement this"
    end
    
    describe "with item" do
      
      before :each do
        another_user = Factory(:user, :email => Factory.next(:email),
                              :name => Factory.next(:name))
        category = Factory(:category)
        @item = another_user.items.create(:category => category.id)
      end
      
      it "should have an item method" do
        @wish.should respond_to(:item)
      end
      
      it "should require connection time when connected to an item" do
        @wish.connected_at.should be_nil
        @wish.item_id.should be_nil
        @wish.connect(@item)
        @wish.connected_at.should_not be_nil  
        @wish.item_id.should_not be_nil      
      end
      
      # describe "after connecting to an item" do
      # 
      #   before :each do
      #     @wish.connect(@item)
      #   end
      # 
      #   it "should have the right item" do 
      #     @wish.item.should == @item
      #     @wish.item_id.should == @item.id
      #   end
      # 
      #   it "should not assocaite to an item belongs to the same user" do
      #     item = @wish.item
      #     @wish.wanter.should_not == item.owner
      #     @wish.wanter_id.should_not == item.owner_id
      #   end
      # end
    end
  end
end
