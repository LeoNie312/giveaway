require 'spec_helper'

describe Item do
  
  before :each do
    @category = Factory(:category)
    @owner = Factory(:user)
    @attr = {:description=>"this is an item", 
        :img_link=>"http://example.com/some_pic",
        :category_id => @category.id}
  end
  
  it "should create a new instance of Item given valid attributes" do
    @owner.items.create!(@attr)
  end
  
  describe "category association" do
    
    before :each do 
      @item = @owner.items.create(@attr)
    end
    
    it "should has a category association" do
      @item.should respond_to(:category)
    end
    
    it "should have the right associated category" do
      @item.category.should == @category
      @item.category_id.should == @category.id
    end
  
  end
  
  describe "wish association" do
    pending
  end
  
  describe "owner association" do
    
    before :each do
      @item = @owner.items.create(@attr)
    end
    
    it "should have an owner method" do
      @item.should respond_to(:owner)
    end
    
    it "should have the right owner" do
      @item.owner.should == @owner
      @item.owner_id.should == @owner.id
    end
  end
  
  describe "validation" do
    
    it "should reject description that is too long" do 
      long = "a"*101
      long_description_item = @owner.items.build(@attr.merge(:description => long))
      long_description_item.should_not be_valid
    end
    
    it "should reject img link that is too long" do 
      long = "a"*101
      long_link_item = @owner.items.build(@attr.merge(:img_link => long))
      long_link_item.should_not be_valid
    end
    
    it "should accept valid img link" do
      links = %w[http://example.com/photos/id/3,
                http://www.example.com/photos.php?id=3,
                http://www.example.com/photo.jpg]
      links.each do |link|
        item = @owner.items.build(@attr.merge(:img_link => link))
        item.should be_valid
      end
    end
    
    it "should reject img link that is not valid" do
      links = %w[example.com/photos/id/3,
                www.example.com/photos.php?id=3,
                www.example.com/photo.jpg,
                http://www.foo,com/photo.jpg,
                http://foo/photo.jpg]
      links.each do |link|
        item = @owner.items.build(@attr.merge(:img_link => link))
        item.should_not be_valid
      end
    end
    
    it "should require the category id" do
      @owner.items.build(@attr.merge(:category_id => nil))
        .should_not be_valid
    end
    
    it "should require the owner id" do
      Item.new(@attr)
        .should_not be_valid
    end
    
    it "should require the onshelf time at creation" do
      item = @owner.items.create(@attr)
      item.onshelf_at.should_not be_nil
    end
    
    it "should require the onshelf time when it's transferred"
  end
  


end
