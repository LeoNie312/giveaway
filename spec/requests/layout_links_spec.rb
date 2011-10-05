require 'spec_helper'

describe "static pages" do
  before :each do 
    @base_title = "NTU GiveAwaY | "
  end
  
  it "should get to homepage at '/'" do
      get '/'
      response.should have_selector('title',:content=> @base_title+'Home')
  end
  
  it "should get to about page at '/about'" do
      get '/about'
      response.should have_selector('title',:content=> @base_title+'About')
  end
  
  it "should get to contact page at '/contact'" do
      get '/contact'
      response.should have_selector('title',:content=> @base_title+'Contact')
  end
  
  describe "when not signed-in" do 
    before :each do
      visit root_path
    end
    
    it "should have a signup button" do 
      response.should have_selector('a', :content=>"Sign Up")
    end
    
    it "should have a signin button" do
      response.should have_selector('a', :content=>"Signin")      
    end
    
    it "should have a about link and it works" do
      response.should have_selector('a', :content=>"What's this?")
      click_link "What's this"
      response.should have_selector('title',:content=>"About")
    end
    
    it "should have a browse button" do
      response.should have_selector('a', :content=>"Browse")
    end
  end

end
