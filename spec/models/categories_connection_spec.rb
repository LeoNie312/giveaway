require 'spec_helper'

describe CategoriesConnection do
  
  before :each do
    @parent_cate = Factory(:category)
    @child_cate = Factory(:category, :name => "drink")
  end

  describe "category association" do
    
    before :each do
      @connection = CategoriesConnection.create(:parent_id=>@parent_cate.id, :child_id=>@parent_cate.id)
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
      CategoriesConnection.new(:child_id => @child_cate.id)
        .should_not be_valid
    end
    
    it "should require child id" do
      CategoriesConnection.new(:parent_id => @child_cate.id)
        .should_not be_valid
    end
  end
end

# == Schema Information
#
# Table name: connections
#
#  id         :integer         not null, primary key
#  parent_id  :integer
#  child_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

