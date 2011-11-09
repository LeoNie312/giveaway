class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  private
  
    # return structure hash or false, 
    # under that root
    def find_categories_under(root)
      
      if root.instance_of? String
        root = Category.find_by_name(root)
        raise "wrong category name" if root.nil?
      end
      
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
    
    def authenticate
      deny_access unless signed_in?
    end
end
