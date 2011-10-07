require 'spec_helper'

describe Category do
  
  before :each do
    @category = Category.create({:name => "base"})
  end

  describe "item associate" do
    
    before :each do
      @item1 = Factory(:item, :category=>@category)
      sleep(1) # this makes @item2 created later than @item1
      @item2 = Factory(:item, :category=>@category)
    end
    
    it "should has an item association" do
      @category.should respond_to(:items)
    end
    
    it "should have the right items in the right order, at items' creation" do
      @category.items.should == [@item2, @item1]
    end
    
    it "should have the right items in the right order, when one item is re-onshelved"
    
    it "should destroy associated items" do
      @category.destroy
      [@item1, @item2].each do |item|
        Item.find_by_id(item.id).should be_nil
      end
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

