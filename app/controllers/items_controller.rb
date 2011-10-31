class ItemsController < ApplicationController
  
  def show
    @item = Item.find_by_id(params[:id])
    if @item.nil?
      redirect_to error_url
    else
      @title = @item.category.name.capitalize + "item"
    end
  end
  
  def create
  end

  def destroy
  end

  def update
  end

end
