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
      
      # if there's old unconnected wish, take that wish out.
      # and if it is a "I want" request, connect the wish 
      # with the item. 
      if (wishes = old_wishes(category)).any?  # private method of this controller
        @wish = wishes.first
        
        if params[:wish][:item_id]
          @item = Item.find(params[:wish][:item_id]) 
          @wish.connect(@item)
        end  
      
      # otherwise, create a new wish record directly, 
      # with or without item_id  
      else
        @wish = current_user.wishes.create!(params[:wish])
      end
      
      redirect_to category
    end

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
