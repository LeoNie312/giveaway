require 'spec_helper'

describe Connection do
  
  before :each do
    @parent_cate = Factory(:category)
    @child_cate = Factory(:category, :name => "drink")
  end

  describe "category association" do
    
    before :each do
      @connection = Connection.create(:parent_id=>@parent_cate.id, :child_id=>@parent_cate.id)
    end
    
    it "should have a parent method" do
      @connection.should respond_to(:parent)
      @connection.parent.should be_instance_of(Category)
    end
    
    it "should have a child method" do
      @connection.should respond_to(:child)
      @connection.child.should be_instance_of(Category)
    end
  end
  
  describe "validation" do
    
    it "should require parent id" do
      Connection.new(:child_id => @child_cate.id)
        .should_not be_valid
    end
    
    it "should require child id" do
      Connection.new(:parent_id => @child_cate.id)
        .should_not be_valid
    end
  end
end
