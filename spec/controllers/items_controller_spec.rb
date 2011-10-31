require 'spec_helper'

describe ItemsController do

  describe "GET 'show'" do
    
    before :each do
      @owner = Factory(:user)
      @category = Factory(:category, :name => "drink")
      @item = @owner.items.create!(:category_id => @category.id,
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

  describe "POST 'create'" do
    it "should be successful" do
      post :create
      response.should be_success
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
