class Movie < ApplicationRecord
  has_many :reviews, :dependent => :destroy

  validates :title, :external_rating, :external_id, presence: true
  validates :external_id, uniqueness: true

  def your_rating
    initial_rating = self.external_rating * 10
    if self.reviews.length > 0
      avg_reviews = self.reviews.map{ |review| review.rating }.reduce(:+)
      (initial_rating.to_i + avg_reviews) / (self.reviews.length + 1)
    else
      initial_rating
    end
  end
end
