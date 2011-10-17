["base", "sprite", "pepsi", "soft drink", 
 "drink", "stationery", "pen", "pencil",
 "coca cola"].each do |category|
   Category.find_or_create_by_name(category)
end

connections = {5=>1, 6=>1, # all base's children
              4=>5, # all drink's children
              2=>4, 3=>4, 9=>4, # all solf-drink's children
              7=>6, # all stationary's children
              8=>7 # all pen's children
              }

Connection.delete_all              
connections.each do |child, parent|
  Connection.create!(:parent_id=>parent, :child_id=>child)
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
