require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    
    describe "when not signed-in" do
      
      it "should be successful" do
        get 'home'
        response.should be_success
      end
      
      it "should not display locations sidebar"
    
    end
    
    describe "when signed-in" do
      
      before :each do
        @user = Factory(:user)
        test_sign_in @user
      end
      
      it "should display locations sidebar"
      
      
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'error'" do
    it "should be successful" do
      get 'error'
      response.should be_success
    end
  end
end
