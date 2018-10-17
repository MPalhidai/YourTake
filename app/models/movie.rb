class Movie < ApplicationRecord
  has_many :reviews, :dependent => :destroy

  validates :title, :external_rating, :external_id, presence: true
  validates :external_id, uniqueness: true
  validates :external_rating, inclusion: { in: 0..10, message: 'the external rating is invalid' }

  def your_rating
    if self.reviews.length > 0
      total_reviews = self.reviews.map{ |review| review.rating }.reduce(:+)
      total_reviews / self.reviews.length
    else
      (self.external_rating * 10).to_i
    end
  end

end
