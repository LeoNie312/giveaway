class PagesController < ApplicationController
  def home
    if signed_in?
      @user = current_user
      @title = "Homepage"
      @locations = Location.all
      
      @hierarchy = find_categories_under("base")
      @item = Item.new
    else
      @title = "Home"
    end
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end
  
  def error
    @title = "Page Not Found"
  end

end
