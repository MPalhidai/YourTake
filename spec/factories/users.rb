FactoryBot.define do
  factory :user do
    name { "user_name" }
    sequence(:email) { |n| "user_#{n}_email@example.com" }
    password { "user_password" }
    password_confirmation { "user_password" }
    confirmed_at { Time.now }
  end
end
