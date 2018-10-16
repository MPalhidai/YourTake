FactoryBot.define do
  factory :user do
    name { "Michael" }
    email { "Michael@gmail.com" }
    password { "michael" }
    password_confirmation { "michael" }
  end
end
