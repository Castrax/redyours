class TicketsJob < ApplicationJob
  queue_as :default
  require 'faker'
  STATUS = [:in_progress, :in_review, :completed]

  def perform(*args)
    morning = 8
    midday = 12
    afternoon = 18
    evening = 22
    current_time = Time.now.hour
    n = (if current_time.between?(morning, midday)
      3
    elsif current_time.between?(midday, afternoon)
      4
    elsif current_time.between?(afternoon, evening)
      5
    else
      10
    end)
    create_ticket if rand(n) == 0
  end

  def raise_error
    puts 'Proceeding error'
    sleep 3
    puts 'Sorry, no ticket created'
    sleep 3
    puts 'Error closed'
  end

  def create_ticket
    puts 'Starting to create a ticket'
    photo_url = 'https://source.unsplash.com/collection/856079'
    ticket = Ticket.create(title: Faker::Hacker.adjective, description: Faker::Hacker.say_something_smart, status: STATUS.sample, user_id: User.pick_a_user.id, open: true, photo_url: photo_url)
    UserMailer.with(user: ticket.user).welcome_ticket_email.deliver_now
    puts 'Ticket created'
  end
end
