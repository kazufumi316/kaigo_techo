FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    tel_number { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
  end
end
