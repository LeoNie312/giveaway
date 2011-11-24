require 'spec_helper'

describe Item do
  
  before :each do
    @drink = drink_cate
    @owner = Factory(:user)
    @attr = {:description=>"this is an item", 
        :img_link=>"http://example.com/some_pic",
        :category_id => @drink.id}
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
      @item.category.should == @drink
      @item.category_id.should == @drink.id
    end
  
  end
  
  describe "wish association" do
    
    before :each do
      @item = @owner.items.create(@attr)      
      another_user = Factory(:user, :email=>Factory.next(:email), :name=>Factory.next(:name))
      other_user = Factory(:user, :email=>Factory.next(:email), :name=>Factory.next(:name))
      category = drink_cate
      @wish1 = Factory(:wish, :wanter=>another_user, :category=>category, 
                      :item_id => @item.id ,:connected_at=>1.day.ago,
                      :created_at => 2.days.ago)
      @wish2 = Factory(:wish, :wanter=>other_user, :category=>category, 
                      :item_id => @item.id, :connected_at=>1.hour.ago,
                      :created_at => 3.days.ago)
    end
    
    it "should have a wishes method" do
      @item.should respond_to(:wishes)
    end
    
    it "should have wishes DESC according to their connection time" do
      @item.wishes.should == [@wish2, @wish1]
    end
    
    it "should disconnect associated wishes at destroy" do 
      @item.destroy
      [@wish1, @wish2].each do |wish|
        Wish.find_by_id(wish.id).should_not be_nil 
        db_wish = Wish.find_by_id(wish.id)
        db_wish.item_id.should be_nil
        db_wish.connected_at.should be_nil
        db_wish.connected.should be_false
      end
    end
    
    it "should not save offshelf item with wishes connected" do
      lambda do
        @item.toggle!(:onshelf)
      end.should raise_exception 
    end
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
  
  describe "transferation" do
    
    before :each do
      @item = @owner.items.create(@attr)
      
      @wanter = Factory(:user, :email => Factory.next(:email), :name => Factory.next(:name))
      @wish1 = Factory(:wish, category_id: @item.category.id,
                item_id: @item.id,
                wanter_id: @wanter.id)
      
      @another_wanter = Factory(:user, :email => Factory.next(:email), :name => Factory.next(:name))
      @wish2 = Factory(:wish, category_id: @item.category.id,
                item_id: @item.id,
                wanter_id: @another_wanter.id)
    end
    
    it "should have a 'transfer!' method" do
      @item.should respond_to(:transfer!)
    end
    
    it "should change the owner" do
      @item.transfer!(@wanter)
      @item.owner.should == @wanter
      @item.owner_id.should == @wanter.id
    end
    
    it "should alert when receiver is the owner itself" do
      lambda do
        @item.transfer!(@owner)
      end.should raise_exception
    end
    
    it "should offshelf the item" do
      @item.transfer!(@wanter)
      @item.should_not be_onshelf
      @item.onshelf_at.should be_nil
    end
    
    it "should disconnect every wish" do
      @item.transfer!(@wanter)
      @item.reload
      @item.wishes.should be_empty
      @wish2.reload
      @wish2.item.should be_nil
      @wish2.should_not be_connected
      @wish2.connected_at.should be_nil
    end
    
    it "should destroy receiver's wish" do
      lambda do        
        @item.transfer!(@wanter)
      end.should change(Wish, :count).by(-1)
      
      lambda do
        @wish1.reload
      end.should raise_exception(ActiveRecord::RecordNotFound)
      
    end
  end
  
  describe "re-onshelf" do
    
    before :each do
      @item = @owner.items.create(@attr)
      @item.onshelf_at = nil
      @item.onshelf = false
      @item.save!
    end
    
    it "should responde to a 're_onshelf' method" do
      @item.should respond_to(:re_onshelf)
    end
    
    it "should have 'onshelf' attribute set to true" do
      @item.re_onshelf
      @item.should be_onshelf
    end
    
    it "should have 'onshelf_at' time calculated" do
      @item.re_onshelf
      time = DateTime.now
      @item.onshelf_at.should_not be_nil
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
      Item.new(@attr.merge(:owner_id => @owner.id))
        .should_not be_valid
    end
    
    it "should require the onshelf time at creation" do
      item = @owner.items.create(@attr)
      item.onshelf_at.should_not be_nil
    end
    
  end
  


end


# == Schema Information
#
# Table name: items
#
#  id          :integer         not null, primary key
#  description :string(255)
#  img_link    :string(255)
#  category_id :integer
#  onshelf     :boolean         default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime
#  onshelf_at  :datetime
#  owner_id    :integer
#

