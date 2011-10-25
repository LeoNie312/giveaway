class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  private
  
    # return structure hash or false, 
    # under that root
    def find_categories_under(root)
      
      if root.children.empty?
        false    
      else
        structure = {}
        
        root.children.each do |child|
          structure[child] = find_categories_under(child)
        end
        
        structure
      end

    end
end
