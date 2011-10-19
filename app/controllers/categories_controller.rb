class CategoriesController < ApplicationController
  
  include CategoriesHelper
  
  def show
    @category = Category.find_by_id(params[:id])
    @title = @category.name.capitalize
    
    @items = []
    # @current_category = @category
    # @current_items = @current_category.items
    # @items.concat @current_items unless @current_items.empty?
    bfs(@category) # method in CategoriesHelper
  end

end
