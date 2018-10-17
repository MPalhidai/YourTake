FactoryBot.define do
  factory :review do
    comment { "Great!!!" }
    rating { 1 }
    external_id { 1 }
    user
    movie
  end
end
