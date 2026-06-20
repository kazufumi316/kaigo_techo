FactoryBot.define do
  factory :care_user do
    family { nil }
    name { Faker::Name.name }
    birthday { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    blood_type { 1 }
    medical_condition_1 { "" }
    medical_condition_2 { "" }
    medical_condition_3 { "" }
  end
end
