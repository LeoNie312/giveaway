class UsersController < ApplicationController
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to GiveAwaY, #{@user.name}\!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
      @user.password = ""
      @user.password_confirmation = ""
    end
  end
  
  def checkin
    location = Location.find_by_name(params[:name])
    current_user.checkin(location)
    respond_to do |format|
      format.html {redirect_to root_url}
      format.js
    end
  end
  
end


