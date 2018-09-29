class Review < ApplicationRecord
  has_one :user, :dependent => :destroy
  has_one :movie, :dependent => :destroy
end
