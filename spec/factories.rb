Factory.define :category do |c|
  c.name "base"
end

Factory.define :item do |i|
  i.description  "this is an item"
  i.img_link     "http://www.example.com/photos/some_pic.jpg"
  i.association  :category
  i.onshelf       true
end

Factory.define :user do |u|
  u.name     "Mark Zuckerberg"
  u.email    "mark@e.ntu.edu.sg"
  u.hp       "84257886"
end