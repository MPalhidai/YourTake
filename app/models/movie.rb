class Movie < ApplicationRecord
  has_many :reviews, :dependent => :destroy

  validates :title, :external_rating, :external_id, presence: true
  validates :external_id, uniqueness: true

  def your_rating
    initial_rating = (self.external_rating * 10).to_i
    if self.reviews.length > 0
      avg_reviews = self.reviews.map{ |review| review.rating }.reduce(:+)
      # call api for vote total. 10 vote external avg weight
      (initial_rating * 10 + avg_reviews) / (self.reviews.length + 10)
    else
      initial_rating
    end
  end
end
