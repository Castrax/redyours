class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tickets
  has_many :assignments
  has_many :comments

  def self.pick_a_user
    users = User.joins(:tickets).where(tickets: { open: true }).sort { |a, b| a.tickets.where(tickets: { open: true }).count <=> b.tickets.where(tickets: { open: true }).count }
    users[0].tickets.where(tickets: { open: true }).size == users[1].tickets.where(tickets: { open: true }).size ? users[0, 2].sample : users[0]
  end
end
