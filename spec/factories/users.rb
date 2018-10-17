FactoryBot.define do
  factory :user do
    name { "Michael" }
    email { "mpalhidai@gmail.com" }
    password { "michael" }
    password_confirmation { "michael" }
    confirmed_at { Time.now }
  end
end
