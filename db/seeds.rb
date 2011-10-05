["base", "sprite", "pepsi", "soft drink", 
 "drink", "stationery", "pen", "pencil",
 "coca cola"].each do |category|
   Category.find_or_create_by_name(category)
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
