require 'spec_helper'

describe Wish do
  
  before :each do
    @category = Factory(:category)
    @wanter = Factory(:user)
    @attr = {
      :category_id => 1,
      :item_id => 1
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
    
    describe "with wanter" do
      
      before :each do
        @wish.save
      end
      
      it "should have a wanter method" do
        @wish.should respond_to(:wanter)
      end
      
      it "should have the right associated wanter" do
        @wish.wanter.should == @wanter
        @wish.wanter_id.should == @wanter.id
      end
    end
    
    describe "with category" do
      pending
    end
    
    describe "with item" do
      pending
    end
  end
end
