class PagesController < ApplicationController
  def home
    @title = "Home"
    
    if signed_in?
      @locations = Location.all
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
