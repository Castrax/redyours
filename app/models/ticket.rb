class Ticket < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :comments, dependant: :destroy
end
