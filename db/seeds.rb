# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "Dropping the database..."
Ticket.destroy_all
User.destroy_all

STATUS = [:in_progress, :in_review, :completed]
OPEN = [true, false]

puts "Creating users..."
u1 = User.create(first_name: 'Mathilde', last_name: 'Robert', email: 'm.robert@skema.edu', password: 'testtest')
u2 = User.create(first_name: 'Aurélie', last_name: 'Rix', email: 'aurelie.test@gmail.com', password: 'testtest')
u3 = User.create(first_name: 'Paula', last_name: 'Richeux', email: 'paula.test@gmail.com', password: 'testtest')
u4 = User.create(first_name: 'Jérémy', last_name: 'Kenigsman', email: 'jeremy.kenigsman@simplebo.fr', password: 'qsdfghjklm')

USERS = [u1.id, u2.id, u3.id]

puts "Creating tickets..."
20.times do
  photo_url = 'https://picsum.photos/300/200'
  Ticket.create(title: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true), description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4), status: STATUS.sample, user_id: USERS.sample, open: OPEN.sample, photo_url: "#{photo_url}?random=#{rand(1..9)}")
end
