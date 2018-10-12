class Movie < ApplicationRecord
  has_many :reviews, :dependent => :destroy

  validates :title, presence: true
  validates :external_rating, presence: true
  validates :external_id, presence: true, uniqueness: true

  attr_accessor :external_id
end
