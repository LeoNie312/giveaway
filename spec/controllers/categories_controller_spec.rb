require 'spec_helper'

describe CategoriesController do

  describe "GET 'show'" do
    
    before :each do
      @base = Factory(:category)
      @item_b1 = Factory(:item, :category_id=>@base.id, 
                        :owner=>Factory(:user))
                       
      get :show, :id => @base
    end
    
    it "should be successful" do
      response.should be_success
    end
    
    # it "should have the right title" do
    #   get :show, :id => @category
    #   response.should have_selector("title", :content => @category.name.capitalize)
    # end
    
    it "should be the right category" do
      assigns(:category).should == @base
    end
    
    it "should have this category's items" 
    
    it "should have "
  end

end
