require 'spec_helper'

describe WishesController do
  render_views

  before :each do
    @base = Factory(:category, name: "base")
    @drink = Factory(:category, name: "drink")
    Factory(:categories_connection, parent: @base, child: @drink)
    @user = Factory(:user)
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
