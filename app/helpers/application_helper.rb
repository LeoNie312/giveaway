module ApplicationHelper
  def title
    base_title = "NTU GiveAwaY"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def categories_hierarchy
        
    base = Category.find_by_name("base")
    
    hierarchy = find_categories_under(base)
    
  end
  
  private
  
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
