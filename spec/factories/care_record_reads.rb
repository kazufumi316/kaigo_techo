FactoryBot.define do
  factory :care_record_read do
    care_record { nil }
    user { nil }
    read_at { Time.current }
  end
end
