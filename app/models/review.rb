class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :comment, :rating, :external_id, :user_id, :movie_id, presence: true
  validates :rating, inclusion: { in: 0..100, message: 'The rating must be between 0 and 100' }
end
