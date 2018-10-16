FactoryBot.define do
  factory :review do
    comment { "Great!!!" }
    rating { 1 }
    external_id { 1000000 }
    user { 1 }
    movie { 1 }
  end
end
