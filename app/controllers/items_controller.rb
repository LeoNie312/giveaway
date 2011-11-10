class ItemsController < ApplicationController
  before_filter :authenticate
  
  def new

  end
  
  def show
    @item = Item.find_by_id(params[:id])
    if @item.nil?
      redirect_to error_url
    else
      @title = @item.category.name.capitalize + " item"
    end
  end
  
  def create
  end

  def destroy
  end

  def update
  end
  
  def search_items
    @title = "Search items"
    @hierarchy = find_categories_under("base")
  end

end
