class TicketsJob < ApplicationJob
  queue_as :default
  require 'faker'
  STATUS = [:in_progress, :in_review, :completed]

  def perform(*args)
    morning = Time.parse('2020-11-23T08:00:00Z').utc.strftime('%H:%M:%S')
    midday = Time.parse('2020-11-23T12:00:00Z').utc.strftime('%H:%M:%S')
    afternoon = Time.parse('2020-11-23T18:00:00Z').utc.strftime('%H:%M:%S')
    evening = Time.parse('2020-11-23T22:00:00Z').utc.strftime('%H:%M:%S')
    current_time = Time.now.utc.strftime('%H:%M:%S')
    # @users = User.all
    random_ten = %i[raise_error raise_error raise_error raise_error raise_error
                    raise_error raise_error raise_error raise_error create_ticket]
    random_five = %i[raise_error raise_error raise_error raise_error create_ticket]
    random_four = %i[raise_error raise_error raise_error create_ticket]
    random_three = %i[raise_error raise_error create_ticket]
    if current_time.between?(morning, midday)
      send random_three.sample
    elsif current_time.between?(midday, afternoon)
      send random_four.sample
    elsif current_time.between?(afternoon, evening)
      send random_five.sample
    else
      send random_ten.sample
    end
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
