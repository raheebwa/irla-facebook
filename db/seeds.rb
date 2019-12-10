# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
    
User.create([{email: "raaheebwa@gmail.com", first_name: "Aheebwa",
         last_name: "Ramadhan", location: "Uganda", password: "password", password_confirmation: "password"}, 
        {email: "israellaguan@gmail.com", first_name: "Israel", last_name: "Laguan", location: "Colombia" , password: "password", password_confirmation: "password"}])

    User.all.each do |user|
        5.times do 
            post = Post.create(user_id: user.id, body: Faker::ChuckNorris.fact, image_path: Faker::LoremPixel.image(size: "640x480") )
            post.likes.build(user_id: user.id, post_id: post.id).save
            3.times{post.comments.create(user_id: user.id, body: Faker::Hacker.say_something_smart)}
        end
    end