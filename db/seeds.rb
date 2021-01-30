# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Post.delete_all

# NUM_OF_POSTS=50

    60.times do
        created_at=Faker::Date.backward(days: 365)
        Post.create(
            title: Faker::Lorem.sentence,
            body: Faker::Lorem.paragraph_by_chars,
            created_at: created_at,
            updated_at: created_at
        )
    end
    p=Post.all
    puts "created #{p.count} posts"