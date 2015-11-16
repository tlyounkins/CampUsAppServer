# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Users
User.create!(username:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             firstname: "examplefirstname",
             lastname: "examplelastname",
             birthday: "1950-01-01",
             bio: "this is my bio",
             major: "computer science",
             hometown: "York,PA",
             age: "65",
             gender: "male",
             admin: true,
             activated: true,
             activated_at: Time.zone.now.to_datetime)

10.times do |n|
  username  = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  firstname = Faker::Name.first_name
  lastname = Faker::Name.last_name
  birthday = "1950-01-01"
  bio = "this is my bio"
  major = "computer science"
  hometown = "York,PA"
  age = Faker::Number.digit
  gender = "male"
  admin = "0"
  User.create!(username:  username,
               email: email,
               password:              password,
               password_confirmation: password,
               firstname: firstname,
               lastname: lastname,
               birthday: birthday,
               bio: bio,
               major: major,
               hometown: hometown,
               age: age,
               gender: gender,
               admin: admin,
               activated: true,
               activated_at: Time.zone.now.to_datetime)
end

# Microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }