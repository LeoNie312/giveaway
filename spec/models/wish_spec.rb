require 'spec_helper'

describe Wish do
  
  before :each do
    @category = Factory(:category)
    @wanter = Factory(:user)
    @wish = @wanter.wishes.build(:category_id=>@category.id)
  end
  
  it "should create a new instance given valid attributes" do 
    @wish.save!
  end
  
  describe "validation" do
    
    it "should require category id"
    
    it "should require wanter id"
    
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
  end
end
