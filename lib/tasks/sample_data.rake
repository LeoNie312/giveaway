require 'faker'

namespace :db do
  desc "Fill atabase with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(
                :name => 'Leo Nie'
                :email => "leo.nie312@gmail.com"
                :hp => "84257886"
                :password => "foobar"
                :password_confirmation => "foobar"
                )
                
    User.create!(
                :name => 'Adam Lee'
                :email => "adam.lee0628@gmail.com"
                :hp => "81761463"
                :password => "foobar"
                :password_confirmation => "foobar"
                )

    98.times do |n|
      name = Faker::Name.name
      email = "huluwa-#{n+1}@example.com"
      hp = '87879090'
      password = "password"
      User.create!(
                  :name => name
                  :email => email
                  :hp => hp
                  :password => password
                  :password_confirmation => password
                  )
      
    end

  end
end