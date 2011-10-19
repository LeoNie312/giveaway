require 'spec_helper'

describe CategoriesController do
  render_views
  
  describe "GET 'show'" do
    
    before :each do
      @base = Factory(:category)
      @drink = Factory(:category, :name => "drink")
      @connection1 = Factory(:connection, :parent_id => @base.id,
                      :child_id => @drink.id)
                      
      @user = Factory(:user)
      @item1 = Factory(:item, :category_id=>@drink.id, 
                        :owner=>@user)                       
    end
    
    it "should be successful" do
      get :show, :id => @base
      response.should be_success
    end
    
    it "should not have the non-record message" do
      response.should_not have_selector("div", :class=>"non-record")
    end
    
    it "should have the right title" do
      get :show, :id => @base
      response.should have_selector("title", :content => @base.name.capitalize)
    end
    
    it "should be the right category" do
      get :show, :id => @base
      assigns(:category).should == @base
    end
    
    it "should have this category's items" do
      get :show, :id => @drink
      response.should have_selector("span",
                      :class => "category-tag",
                      :content => @drink.name.capitalize)
    end
    
    it "should have children category's items" do
      
      @soft_drink = Factory(:category, :name => "soft drink")
      @connection2 = Factory(:connection, :parent_id => @drink.id,
                      :child_id => @soft_drink.id)
      @item2 = Factory(:item, :category_id => @soft_drink.id,
                      :owner => @user)
      
      get :show, :id => @base
      response.should have_selector("span",
                      :class=> "category-tag",
                      :content => @drink.name.capitalize)
                      
      response.should have_selector("span",
                      :class=> "category-tag",
                      :content => @soft_drink.name.capitalize)
    end
    
    it "should never include base category's items" do

      unexpected_item = Factory(:item, :category_id => @base.id,
                      :owner => @user)
      get :show, :id => @base
      response.should_not have_selector("span",
                      :class=>"category-tag",
                      :content => @base.name.capitalize)
    end
  end

end
