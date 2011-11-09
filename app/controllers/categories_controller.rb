class CategoriesController < ApplicationController
  before_filter :authenticate
  
  include CategoriesHelper
  
  def show
    @category = Category.find_by_id(params[:id])
    
    if @category.nil?
      redirect_to error_url
      return
    end
    
    unless @category.name == "base"
      @title = @category.name.capitalize
    else
      @title = "All items"
    end
    
    @items = find_items_under(@category) # method in CategoriesHelper
    
    # for categories sidebar
    base = Category.find_by_name("base")
    @hierarchy = find_categories_under(base) # private method in application_controller 
  end

end
