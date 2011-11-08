module ApplicationHelper
  def title
    base_title = "NTU GiveAwaY"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def base_category
    Category.find_by_name("base")
  end
end
