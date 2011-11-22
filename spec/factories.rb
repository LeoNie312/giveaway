drink = Category.find_by_name("drink")


Factory.define :item do |i|
  i.description  "this is an item"
  i.img_link     "http://www.example.com/photos/some_pic.jpg"
  i.category_id   drink.id
  i.association  :owner
  i.onshelf       true
  i.onshelf_at    1.day.ago
end

Factory.define :user do |u|
  u.name     "Mark Zuckerberg"
  u.email    "mark@e.ntu.edu.sg"
  u.hp       "84257886"

  u.password "foobar"
  u.password_confirmation "foobar"
  

end

Factory.define :wish do |w|
  w.association :wanter
  w.association :category
end

Factory.sequence :email do |n|
  "person-#{n}@e.ntu.edu.sg"
end

Factory.sequence :name do |n|
  "person-#{n}"
end

Factory.define :users_location do |u|
  
end