class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_id(params[:id])
    @title = @category.name.capitalize
    
    @items = []
    @current_category = @category
    @current_items = @current_category.items
    @items.concat @current_items
  end

end
