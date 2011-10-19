module CategoriesHelper
  
  private
  
    def bfs(parent)
      
      unless parent.parent.nil?
        items = parent.items 
        @items.concat(items)
      end
      
      q = []
      q.push parent
      
      until q.empty?
        parent = q.first
        children = parent.children.to_enum
        child = begin children.next rescue nil end
        
        until child.nil?
          items = child.items
          @items.concat(items)
          
          q.push child
          child = begin children.next rescue nil end
        end
        q.shift
      end
    
    end
end
