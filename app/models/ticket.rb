class Ticket < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :comments, dependent: :destroy
  enum status: [:in_progress, :in_review, :completed]
end
