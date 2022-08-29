# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
Comment.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('comments')

Article.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('articles')

User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')


5.times do
    User.create(email: Faker::Internet.email, password:"123456")
end

10.times do
    Article.create(title: Faker::DcComics.title, content: Faker::Quote.yoda, user: User.find(rand(1..5)))
end

25.times do
    Comment.create(content: Faker::Quote.yoda, user: User.find(rand(1..5)), article: Article.find(rand(1..10)))
end