require 'spec_helper'

describe CategoriesController do
  render_views
  
  describe "GET 'show'" do
    
    before :each do
      @base = Factory(:category)
      @item_b1 = Factory(:item, :category_id=>@base.id, 
                        :owner=>Factory(:user))                       
    end
    
    it "should be successful" do
      get :show, :id => @base
      response.should be_success
    end
    
    # it "should have the right title" do
    #   get :show, :id => @category
    #   response.should have_selector("title", :content => @category.name.capitalize)
    # end
    
    it "should be the right category" do
      get :show, :id => @base
      assigns(:category).should == @base
    end
    
    it "should have this category's items" do
      get :show, :id => @base
      response.should have_selector("span",
                      :class => "category-tag",
                      :content => @base.name.capitalize)
    end
    
    it "should have children category's items" do
      @drink = Factory(:category, :name => "drink")
      @connection1 = Factory(:connection, :parent_id => @base.id,
                      :child_id => @drink.id)
      response.should have_selector("span",
                      :class=> "category-tag",
                      :content => @drink.name.capitalize)
    end
  end

end
