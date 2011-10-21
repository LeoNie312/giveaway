module CategoriesHelper
  
  private
  
    def find_items_under(root)
      
      items = []
      
      unless root.parent.nil?
        items.concat root.items 
      end
      
      q = []
      q.push root
      
      until q.empty?
        parent = q.first
        children = parent.children.to_enum
        child = begin children.next rescue nil end
        
        until child.nil?
          items.concat child.items
          
          q.push child
          child = begin children.next rescue nil end
        end
        q.shift
      end
      
      items
    end
end
