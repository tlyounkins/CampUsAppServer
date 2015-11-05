# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
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
             admin: true)

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
               admin: admin)
end