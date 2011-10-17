require 'spec_helper'

describe Connection do

  describe "category association" do
    
    before :each do
      @parent_cate = Factory(:category)
      @child_cate = Factory(:category, :name => "drink")
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
end
