class WishesController < ApplicationController
  before_filter :authenticate
  
  # def new
  #   @title = "New Wish"
  #   @hierarchy = find_categories_under("base")
  # end
  # 
  
  def create
    category = Category.find_by_id(params[:wish][:category_id])
    
    if category.nil?
      flash[:error] = "unexpected error"
      base = Category.find_by_name("base")
      redirect_to base
    else

      # unless there are old wishes, create new wish,
      # otherwise leave it alone
      unless old_wishes(category).any?
        @wish = current_user.wishes.create!(params[:wish])
      end
      redirect_to category, :notice => "successfully remembered"
    end
  end
  
  def connect
    category = Category.find_by_id(params[:wish][:category_id])
    @wish = current_user.wishes.create!(params[:wish])    
    @item = Item.find(params[:wish][:item_id]) 
    @wish.connect(@item)
    redirect_to category, :notice => "Ok you want this #{category.name}"
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
