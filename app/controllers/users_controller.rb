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
      flash[:success] = "Welcome to GiveAwaY, #{@user.name}\!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
      @user.password = ""
      @user.password_confirmation = ""
    end
  end
  
end
