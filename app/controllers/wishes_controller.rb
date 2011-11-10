class WishesController < ApplicationController
  before_filter :authenticate
  
  def new
    @title = "New Wish"
    @hierarchy = find_categories_under("base")
  end
  
  def create
    category = Category.find_by_id(params[:wish][:category_id])

    if category.nil?
      @title = "New Wish"
      @hierarchy = find_categories_under("base")
      flash.now[:error] = "unexpected error"
      render 'new'
    else
      
      # if there's old unconnected wish, take that wish out.
      if (wishes = old_wishes(category)).any?  # private method of this controller
        @wish = wishes.first
              
      # otherwise, create a new wish record directly
    
      else
        @wish = current_user.wishes.create!(params[:wish])
      end
      
      # if there is old same wish exists, which hasn't connected to
      # any item yet, redirect to category page without creating a
      # new wish
      
      redirect_to category
    end

  end
  
  def connect
    @wish = current_user.wishes.create!(params[:wish])    
    @item = Item.find(params[:wish][:item_id]) 
    @wish.connect(@item)
    redirect_to root_path     
  end
  
  def destroy
  end
  
  private
  
    def old_wishes(category)
      Wish.where(:category_id => category, 
                 :wanter_id => current_user,
                 :item_id => nil)
    end

end
