class Review < ApplicationRecord
  has_one :user, :dependent => :destroy
  has_one :movie, :dependent => :destroy

  validates :comment, presence: true
  validates :rating, presence: true, inclusion: { in: 0..100, message: 'The rating must be between 0 and 100' }
end
