require 'spec_helper'

describe CategoriesController do
  render_views
  
  describe "GET 'show'" do
    
    before :each do
      @base = Category.find_by_name("base")
      @drink = Category.find_by_name("drink")
      # @connection1 = Factory(:categories_connection, :parent_id => @base.id,
      #                 :child_id => @drink.id)
                      
      @user = Factory(:user)
      test_sign_in @user
      @item1 = Factory(:item, :category_id=>@drink.id, 
                        :owner=>@user)                       
    end
    
    it "should be successful" do
      get :show, :id => @base
      response.should be_success
    end
    
    it "should redirect to error page when categories not found" do
      get :show, :id => 100000
      response.should redirect_to(error_path)
    end
    
    it "should have the right title" do
      get :show, :id => @drink
      response.should have_selector("title", :content => @drink.name.capitalize)
    end
    
    it "should replace base's name with something else" do
      get :show, :id => @base
      response.should have_selector('h1', content: "All items")
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
      
      @soft_drink = Category.find_by_name("soft drink")
      @item2 = Factory(:item, :category_id => @soft_drink.id,
                      :owner => @user)
                      
      @stationery = Category.find_by_name("stationery")

      @item4 = Factory(:item, :category_id => @stationery.id,
                      :owner => @user)
                      
      get :show, :id => @base
      response.should have_selector("span",
                      :class=> "category-tag",
                      :content => @drink.name.capitalize)
                      
      response.should have_selector("span",
                      :class=> "category-tag",
                      :content => @soft_drink.name.capitalize)
                      
      response.should have_selector("span",
                      :class=> "category-tag",
                      :content => @stationery.name.capitalize)
    end
    
    it "should never include base category's items" do
      unexpected = Factory(:item, category_id: @base.id,
                      owner: @user)
      response.should_not have_selector("span",
                      :class => "category-tag",
                      :content => @base.name.capitalize)
    end
    
    it "should show 'no record' message when no item found" do
      @soft_drink = Category.find_by_name("soft drink")
                
      get :show, :id => @soft_drink
      response.should have_selector("p",
                      :content => "no record")
      # response.should have_selector("span",
      #                 :class => "wish-memo",
      #                 :content => '<input type="submit" value="Memo my wish">')
    end
    
    describe "categories sidebar" do
      
      before :each do
        @soft_drink = Category.find_by_name("soft drink")
        @coke = Category.find_by_name("coca cola")
      end
      
      it "should have a nested categories structure" do
        get :show, :id => @base
        response.should have_selector('ul li', id: "#{@drink.name}")
        response.should have_selector('ul li ul li', id: "#{@soft_drink.name}")
        response.should have_selector('ul li ul li ul li', id: "#{@coke.name}")        
      end
      
      it "should get the same result by different :id" do
        get :show, :id => @drink
        response.should have_selector('ul li', id: "#{@drink.name}")
        response.should have_selector('ul li ul li', id: "#{@soft_drink.name}")
        response.should have_selector('ul li ul li ul li', id: "#{@coke.name}")        
      end
    end
  end
  
  describe "authentication" do
    
    before :each do
      @base = Category.find_by_name("base")
      @drink = Category.find_by_name("drink")

      @user = Factory(:user)
      @item1 = Factory(:item, :category_id=>@drink.id, 
                        :owner=>@user)
    end
    
    it "should be redirect to signin path" do
      get :show, :id => @base
      response.should redirect_to(signin_path)
    end
  end

end
