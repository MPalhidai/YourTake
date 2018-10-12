class Review < ApplicationRecord
  has_one :user, :dependent => :destroy
  has_one :movie, :dependent => :destroy

  validates :comment, presence: true
  validates :rating, presence: true, inclusion: { in: 0..100, message: 'The rating must be between 0 and 100' }
  validates :external_id, presence: true
  validates :user_id, presence: true
  validates :movie_id, presence: true
end
