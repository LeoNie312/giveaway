class WishesController < ApplicationController
  def create
    @wish = current_user.wishes.create(params[:wish])
    @item = Wish.find(params[:wish][:item_id])
    @wish.connect(@item)
  end

  def destroy
  end

end
