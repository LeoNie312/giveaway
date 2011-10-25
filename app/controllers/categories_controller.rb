class CategoriesController < ApplicationController
  
  include CategoriesHelper
  
  def show
    @category = Category.find_by_id(params[:id])
    
    if @category.nil?
      redirect_to error_url
      return
    end
    
    @title = @category.name.capitalize
    
    # @current_category = @category
    # @current_items = @current_category.items
    # @items.concat @current_items unless @current_items.empty?
    @items = find_items_under(@category) # method in CategoriesHelper
    
    base = Category.find_by_name("base")
    @hierarchy = find_categories_under(base) # private method in application_controller 
  end

end
