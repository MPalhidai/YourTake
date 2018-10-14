class Movie < ApplicationRecord
  has_many :reviews, :dependent => :destroy

  validates :title, :external_rating, :external_id, presence: true
  validates :external_id, uniqueness: true
end
