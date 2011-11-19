class ItemsController < ApplicationController
  before_filter :authenticate
  
  def show
    @item = Item.find_by_id(params[:id])
    if @item.nil?
      redirect_to error_url
    else
      @title = @item.category.name.capitalize + " item"
    end
  end
  
  def new
    @title = "New Item"
    @item = Item.new
    @hierarchy = find_categories_under("base")
  end
    
  def create
    category = Category.find_by_name(params[:category_name])
    category = nil if category.respond_to?(:name) && category.name == "base"
        
    @item = current_user.items.build(description: params[:item][:description],
                                    img_link: params[:item][:img_link])
    @item.category = category
    
    if @item.save
      flash[:success] = "successfully created a new item"
      redirect_to category
    else
      @hierarchy = find_categories_under("base")      
      render :new
    end
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
