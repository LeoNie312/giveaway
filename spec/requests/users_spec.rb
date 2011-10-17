require 'spec_helper'

describe "Users" do
  describe "signup" do
    
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with => ""
          fill_in "Your NTU Email", :with => ""
          fill_in "Mobile Number", :with => ""
          fill_in "Password", :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end
    
    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in :user_name, :with => "Example User"
          fill_in :user_email, :with => "li0044ng@e.ntu.edu.sg"
          fill_in :user_password, :with => "foobar"
          fill_in :user_password_confirmation, :with => "foobar"
          fill_in :user_hp, :with => "12345678"
          click_button
          response.should have_selector("div.flash.success", :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
  end
  
  describe "sign in/out" do
    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in :session_email, :with => ""
        fill_in :session_password, :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end
    
    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit signin_path
        response.should have_selector("title", :content => "Sign in")
        fill_in :session_email, :with => user.email
        fill_in :session_password, :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end

end
