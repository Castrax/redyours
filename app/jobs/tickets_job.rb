class TicketsJob < ApplicationJob
  queue_as :default
  require 'faker'
  STATUS = ['In progress', 'In review', 'Completed']

  def perform(*args)
    # Do something later
    @users = User.all
    puts "Starting to create a ticket"
    photo_url = 'https://source.unsplash.com/collection/856079'
    Ticket.create(title: Faker::Hacker.adjective, description: Faker::Hacker.say_something_smart, status: STATUS.sample, user_id: USERS.sample, open: true, photo_url: photo_url)
    puts "Ticket created"
  end
end
