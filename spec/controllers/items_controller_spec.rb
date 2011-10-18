require 'spec_helper'

describe ItemsController do

  describe "GET 'create'" do
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
