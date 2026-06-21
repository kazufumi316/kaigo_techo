FactoryBot.define do
  factory :care_record do
    health_status { 1 }
    appetite { 1 }
    sleep_quality { 1 }
    memo { "MyString" }
    care_user { nil }
    user { nil }
  end
end
