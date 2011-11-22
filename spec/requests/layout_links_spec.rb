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
  
  it "should get to signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => @base_title + 'Sign up')
  end
  
  it "should get to error page at '/error'" do
    get '/error'
    response.should have_selector('title', content: @base_title + 'Page Not Found')
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
    
    it "should have a home link and it works" do
      response.should have_selector('a', :content=>"Home")
      click_link "Home"
      response.should have_selector('title',:content=>"Home")      
    end
    
    it "should have a contact link and it works" do
      response.should have_selector('a', :content=>"Contact us")
      click_link "Contact us"
      response.should have_selector('title',:content=>"Contact")      
    end
  end

  describe "when signed in" do
    before(:each) do
      @base = base_cate
      @drink = drink_cate

      @user = Factory(:user)
      visit signin_path
      fill_in :session_email, :with => @user.email
      fill_in :session_password, :with => @user.password
      click_button
    end
    
    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path, :content => "Sign out")
    end
    
    it "should have a personal homepage link" do
      visit root_path
      response.should have_selector("a", :href => root_path, :content => "Homepage")
    end

  end

end
