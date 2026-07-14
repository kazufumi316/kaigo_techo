# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create!(
  name: "kaka",
  tel_number: "00000000000",
  email: "ka01@example.com",
  password: "kakaka"
)

family = Family.create!()

family_member = FamilyMember.create!(
  user: user,
  family: family,
  role: :main
)

care_user_1 = CareUser.create!(
  name: "権蔵",
  birthday: "1988-03-16",
  blood_type: "O型",
  family: family
)

family_2 = Family.create!()

family_member_2 = FamilyMember.create!(
  user: user,
  family: family_2,
  role: :main
)

care_user_2 = CareUser.create!(
  name: "茂子",
  birthday: "1983-08-08",
  blood_type: "A型",
  medical_condition_1: "認知症",
  medical_condition_2: "高血圧",
  family: family_2
)

care_users = [care_user_1, care_user_2]

20.times do
  CareRecord.create!(
    health_status: CareRecord.health_statuses.keys.sample,
    appetite: CareRecord.appetites.keys.sample,
    sleep_quality: CareRecord.sleep_qualities.keys.sample,
    memo: Faker::Lorem.sentence,
    user: user,
    care_user: care_users.sample,
    created_at: Faker::Time.between(from: 3.months.ago, to: Time.current)
  )
end