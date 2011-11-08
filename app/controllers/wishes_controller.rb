class WishesController < ApplicationController
  before_filter :authenticate
  
  def new
    @title = "New Wish"
    @hierarchy = find_categories_under("base")
  end
  
  def create
    category = Category.find_by_id(params[:wish][:category_id])
    @wish = current_user.wishes.build(params[:wish])
    
    if @wish.save
      redirect_to category
    else
      @title = "New Wish"
      @hierarchy = find_categories_under("base")
      render 'new'
      flash.now[:error] = "unexpected error"
    end
  end

  def destroy
  end

end
