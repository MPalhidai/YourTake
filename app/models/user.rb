class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  has_many :reviews, :dependent => :destroy

  def get_reviews
    Review.where(user_id: self.id)
  end
end
