class CategoriesController < ApplicationController
  
  include CategoriesHelper
  
  def show
    @category = Category.find_by_id(params[:id])
    @title = @category.name.capitalize
    
    # @current_category = @category
    # @current_items = @current_category.items
    # @items.concat @current_items unless @current_items.empty?
    @items = find_items_under(@category) # method in CategoriesHelper
  end

end
