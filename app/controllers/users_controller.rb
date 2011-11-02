class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  
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

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
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


