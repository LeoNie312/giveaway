require 'spec_helper'

describe ItemsController do
  render_views
    
  before :each do
    @base = Category.find_by_name("base")
    @drink = Category.find_by_name("drink")
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
      get :show, :id => 100000
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
              :category_id => nil }
    end
    
    describe "failure" do
      
      it "should deny the 'base' category" do
        lambda do
          post :create, :item => @attr, :category_name => @base.name
          response.should render_template(:new)
        end.should_not change(Item, :count)
      end
      
      it "should deny unrecognized category" do
        lambda do
          post :create, :item => @attr, :category_name => "unrecognized category"
          response.should render_template(:new)
        end.should_not change(Item, :count)
      end
    end
    
    describe "success" do
      
      it "should create a new item" do
        lambda do
          post :create, :item => @attr, :category_name => @drink.name
        end.should change(Item, :count).by(1)
      end
      
      it "should redirect to category page" do
        post :create, :item => @attr, :category_name => @drink.name
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
  
  describe "UPDATE 'transfer'" do
    
    before :each do
      @user = Factory(:user)
      test_sign_in @user
      
      @item = Factory(:item, :category_id => @drink.id, :owner => @user)
      @receiver = Factory(:user, :name => Factory.next(:name), :email => Factory.next(:email))
    end
    
    it "should be redirect" do
      put :transfer, :id => @item.id, :receiver_id => @receiver
      response.should be_redirect
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
