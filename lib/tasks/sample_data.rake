require 'faker'

namespace :db do
  desc "Fill atabase with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(
                :name => 'Leo Nie',
                :email => "leo.nie312@e.ntu.edu.sg",
                :hp => "84257886",
                :password => "foobar",
                :password_confirmation => "foobar"
                )
                
    User.create!(
                :name => 'Adam Lee',
                :email => "adam.lee0628@e.ntu.edu.sg",
                :hp => "81761463",
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
end