FactoryBot.define do
  factory :care_user do
    family { nil }
    name { "MyString" }
    birthday { "2026-06-20" }
    blood_type { 1 }
    medical_condition_1 { "MyString" }
    medical_condition_2 { "MyString" }
    medical_condition_3 { "MyString" }
  end
end
