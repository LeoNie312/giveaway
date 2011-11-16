require 'spec_helper'

describe ItemsController do
  render_views
    
  before :each do
    @base = Factory(:category, name: "base")
    @drink = Factory(:category, name: "drink")
    Factory(:categories_connection, parent: @base, child: @drink)
  end

  describe "GET 'show'" do
    
    before :each do
      @owner = Factory(:user)
      test_sign_in @owner
      @item = @owner.items.create!(:category_id => @drink.id,
                        description: "a fresh ginger beer",
                        img_link: "http://ramblingspoon.com/blog/wp-content/uploads/2006/12/BlogGingerBeer.jpg")
    end
    
    it "should be successful" do
      get :show, :id => @item.id
      response.should be_success
    end
    
    it "should redirect to error page at non-existent item" do
      get :show, :id => 10000
      response.should redirect_to(error_url)
    end
  end
  
  describe "GET 'new'" do
    
    before :each do
      @user = Factory(:user)
      test_sign_in @user
    end
    
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", content: "New Item")
    end
  end

  describe "POST 'create'" do
    
    before :each do
      @user = Factory(:user)
      test_sign_in @user
      @attr = {:description => "some text", :img_link => "http://google.com/sample.jpg",
                :category => @drink.name }
    end
    
    describe "failure" do
      
      it "should deny the 'base' category" do
        @base = Factory(:category, :name => "base")
        lambda do
          post :create, :item => @attr.merge(:category => @base.name)
          response.should redirect_to(new_item_url)
        end.should_not change(Item, :count)
      end
      
      it "should deny unrecognized category" do
        lambda do
          post :create, :item => @attr.merge(:category => "unrecognized category")
          response.should redirect_to(new_item_url)
        end.should_not change(Item, :count)
      end
    end
    
    describe "success" do
      
      it "should create a new item" do
        lambda do
          post :create, :item => @attr
        end.should change(Item, :count).by(1)
      end
      
      it "should redirect to category page" do
        post :create, :item => @attr
        response.should redirect_to(@drink)
      end
    end
  end
  
  describe "GET 'search_items'" do
    
    before :each do
      @user = Factory(:user)
      test_sign_in @user
    end
    
    it "should be successful" do
      get :search_items
      response.should be_success
    end
    
    it "should have the right title" do
      get :search_items
      response.should have_selector("title", content: "Search items")
    end
  end
  
  describe "authentication" do
    
    before :each do
      @user = Factory(:user)
    end
    
    it "should deny access to 'show'" do
      @item = Factory(:item, :owner_id => @user, :category_id => @drink)
      get :show, :id => @item
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'search_items'" do
      get :search_items
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'new'" do
      get :new
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'create'" do
      get :create
      response.should redirect_to(signin_path)
    end
  end

  # describe "GET 'update'" do
  #   it "should be successful" do
  #     get :update
  #     response.should be_success
  #   end
  # end
  # 
  # describe "GET 'destroy'" do
  #   it "should be successful" do
  #     get :destroy
  #     response.should be_success
  #   end
  # end

end
