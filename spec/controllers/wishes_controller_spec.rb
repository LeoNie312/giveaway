require 'spec_helper'

describe WishesController do
  render_views

  before :each do
    @base = Factory(:category, name: "base")
    @drink = Factory(:category, name: "drink")
    Factory(:categories_connection, parent: @base, child: @drink)
    @user = Factory(:user)
  end

  describe "GET 'new'" do
    
    before :each do
      test_sign_in @user

      stationery = Factory(:category, name: "stationery")
      Factory(:categories_connection, parent: @base, child: stationery)    
      soft_drink = Factory(:category, name: "soft drink")
      Factory(:categories_connection, parent: @drink, child: soft_drink)    
      pen = Factory(:category, name: "pen")
      Factory(:categories_connection, parent: stationery, child: pen)    
      pencil = Factory(:category, name: "pencil")
      Factory(:categories_connection, parent: stationery, child: pencil)
    end
    
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", content: "New Wish")
    end 
  end

  describe "POST 'create'" do
    
    describe "failure" do
      
      before :each do
        test_sign_in @user
        @attr = {category_id: nil}
      end
      
      it "should not create a wish" do
        lambda do
          post :create, :wish => @attr
        end.should_not change(Wish, :count)  
      end
      
      it "should have the right title" do
        post :create, :wish => @attr
        response.should have_selector("title", content: "New Wish")
      end
      
      it "should render the 'new' page" do
        post :create, :wish => @attr
        response.should render_template(:new)
      end
    end
    
    describe "success" do
      
      before :each do
        test_sign_in @user
        @attr = {category_id: @drink}
      end
      
      it "should create a wish" do
        lambda do
          post :create, :wish => @attr
        end.should change(Wish, :count).by(1)
      end
      
      it "should redirect to category show page" do
        post :create, :wish => @attr
        response.should redirect_to(category_path(@drink))
      end
    end
  end

  describe "DELETE 'destroy'" do
    # it "should be successful" do
    #   delete 'destroy'
    #   response.should be_success
    # end
  end
  
  describe "authentication" do
    
    it "should deny access to 'new'" do
      get :new
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'create'" do
      @attr = {category_id: @drink}
      post :create
      response.should redirect_to(signin_path)
    end
  end

end
