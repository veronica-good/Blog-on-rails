# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Post.delete_all
Comment.delete_all
User.delete_all

PASSWORD='supersecret'
super_user= User.create(
    name: 'John',    
    email: 'js@winterfell.gov',
    password: PASSWORD
 )
10.times do
    User.create(
        name: Faker::Name.first_name,
        email: Faker::Internet.email, 
        password: PASSWORD
    )
end

users=User.all

# NUM_OF_POSTS=50

    60.times do
        created_at=Faker::Date.backward(days: 365)
        p=Post.create(
            title: Faker::Lorem.sentence,
            body: Faker::Lorem.paragraph_by_chars,
            created_at: created_at,
            updated_at: created_at, 
            user: users.sample
        )
        if p.valid?
            p.comments=rand(0..15).times.map do
                Comment.new(
                    body: Faker::GreekPhilosophers.quote,
                    user: users.sample
                )
            end
        end
    end
posts = Post.all
comments = Comment.all
puts "created #{posts.count} posts, #{comments.count} comments"