class WishesController < ApplicationController
  before_filter :authenticate
  
  def new
    @title = "New Wish"
    @hierarchy = find_categories_under("base")
  end
  
  def create
    category = Category.find_by_id(params[:wish][:category_id])
    
    # if there is old same wish exists, which hasn't connected to
    # any item yet, redirect to category page without creating a
    # new wish


    if category.nil?
      @title = "New Wish"
      @hierarchy = find_categories_under("base")
      flash.now[:error] = "unexpected error"
      render 'new'
    else
      unless old_wishes_exist?(category)  # private method of this controller
        @wish = current_user.wishes.build(params[:wish])
        @wish.save!
      end
      redirect_to category
    end

  end

  def destroy
  end
  
  private
  
    def old_wishes_exist?(category)
      Wish.where(:category_id => category, 
                 :wanter_id => current_user,
                 :item_id => nil).any?
    end

end
