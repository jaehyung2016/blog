# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# article_content = File.read("db/article.txt")
# puts article_content
# exit

article_contents = []
File.foreach("db/article.txt") do |line|
  article_contents << line
end

User.destroy_all

User.create! email: "admin@email.net", password: "password", first_name: "Admin", last_name: "", is_admin: true

users = []

('A'..'C').each do |char|
  users << User.create!(
    email: "user_#{char.downcase}@example.com",
    password: char,
    first_name: "First_#{char}",
    last_name: "Last_#{char}"
  )

end

(1..18).each do |num|
  users.sample.posts.create! title: "Article #{num}",
    content: article_contents.sample
end

