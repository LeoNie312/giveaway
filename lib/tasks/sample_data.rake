require 'faker'

namespace :db do
  desc "Fill atabase with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_items
  end
end



def make_users
  User.create!(
              :name => 'Leo Nie',
              :email => "z090255@e.ntu.edu.sg",
              :hp => "84257886",
              :password => "foobar",
              :password_confirmation => "foobar"
              )
              
  User.create!(
              :name => 'Adam Li',
              :email => "li0044ng@e.ntu.edu.sg",
              :hp => "81771463",
              :password => "foobar",
              :password_confirmation => "foobar"
              )

  98.times do |n|
    name = Faker::Name.name
    email = "huluwa-#{n+1}@e.ntu.edu.sg"
    hp = '87879090'
    password = "password"
    User.create!(
                :name => name,
                :email => email,
                :hp => hp,
                :password => password,
                :password_confirmation => password
                )
    
  end
end

def make_items
  
  categories = Category.count - 1
  
  User.all(:limit=>6).each do |user|
    categories.times do |n|
      user.items.create!(:description => Faker::Lorem.sentence(5),
                         :img_link => "http://www.example#{user.id}.com/sample#{n}.jpg",
                         :category_id => n+2)
    end
  end  
end










