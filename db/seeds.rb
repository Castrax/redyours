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
u1 = User.create(first_name: 'Mathilde', last_name: 'Robert', email: 'm.robert@skema.edu', password: 'testtest', opened_tickets: 0)
u2 = User.create(first_name: 'Aurélie', last_name: 'Rix', email: 'aurelie.rix@gmail.com', password: 'testtest')
u3 = User.create(first_name: 'Paula', last_name: 'Richeux', email: 'paula.richeux@gmail.com', password: 'testtest')

USERS = [u1.id, u2.id, u3.id]

puts "Creating tickets..."
10.times do
  photo_url = 'https://source.unsplash.com/collection/856079'
  Ticket.create(title: Faker::Hacker.adjective, description: Faker::Hacker.say_something_smart, status: STATUS.sample, user_id: USERS.sample, open: OPEN.sample, photo_url: photo_url)
end
