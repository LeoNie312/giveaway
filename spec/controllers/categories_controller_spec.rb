require 'spec_helper'

describe CategoriesController do

  describe "GET 'show'" do
    
    before :each do
      @category = Factory(:category)
    end
    
    it "should be successful" do
      get :show, :id => @category
      response.should be_success
    end
    
    # it "should have the right title" do
    #   get :show, :id => @category
    #   response.should have_selector("title", :content => @category.name.capitalize)
    # end
  end

end
