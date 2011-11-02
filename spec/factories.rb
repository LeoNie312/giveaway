Factory.define :category do |c|
  c.name "base"
end

Factory.define :item do |i|
  i.description  "this is an item"
  i.img_link     "http://www.example.com/photos/some_pic.jpg"
  i.association  :owner
  i.onshelf       true
  i.category_id   1
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

Factory.define :connection do |c|
  
end

Factory.define :location do |l|
  
end

Factory.define :users_location do |u|
  
end