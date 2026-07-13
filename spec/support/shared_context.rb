RSpec.shared_context "アカウント登録" do
  before do
    visit new_user_registration_path
    @name = Faker::Name.name
    @phone_number = Faker::PhoneNumber.phone_number
    @email = Faker::Internet.email
    fill_in '氏名', with: @name
    fill_in '電話番号', with: @phone_number
    fill_in 'メールアドレス', with: @email
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認用）', with: 'password'
    click_button "登録"
  end
end

RSpec.shared_context "アカウントログイン" do
  let(:user) { create(:user) }
  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button "ログイン"
    expect(page).to have_current_path(homes_path)
  end
end

RSpec.shared_context "見守り家族作成" do
  before do
    click_on '見守り家族登録'
    @dammy_name = Faker::Name.name
    @dammy_date = Faker::Date.between(from: '1940-01-01', to: '1960-01-01')
    fill_in 'care_user_name', with: @dammy_name
    fill_in 'care_user_birthday', with: @dammy_date
    select 'A型', from: 'care_user_blood_type'
    click_on '登録'

    puts "DEBUG: CareUser.count=#{CareUser.count}"
    puts "DEBUG: Family.count=#{Family.count}"
    puts "DEBUG: FamilyMember.count=#{FamilyMember.count}"
    puts "DEBUG: FamilyMember records: #{FamilyMember.all.map { |fm| [fm.user_id, fm.family_id, fm.role] }}"
    puts "DEBUG: current test user id=#{user.id}"
  end
end

RSpec.shared_context "見守り家族2人目作成" do
  before do
    visit homes_path
    click_on '見守り家族登録'
    @dammy_name_2 = Faker::Name.name
    @dammy_date_2 = Faker::Date.between(from: '1940-01-01', to: '1960-01-01')
    fill_in 'care_user_name', with: @dammy_name_2
    fill_in 'care_user_birthday', with: @dammy_date_2
    select 'B型', from: 'care_user_blood_type'
    click_on '登録'
  end
end

RSpec.shared_context "介護記録作成" do
  before do
    visit homes_path
    click_on '記録をつける'
    expect(page).to have_content("体調はどうですか？")
    click_on '変わらない'
    expect(page).to have_content("食欲はありますか？")
    click_on 'あり'
    expect(page).to have_content("睡眠はどうでしたか？")
    click_on '少ない'
    expect(page).to have_content("普段と違うことがあれば")
    click_on '記録する'
  end
end

RSpec.shared_context "介護記録作成2人目" do
  before do
    visit homes_path
    click_on '記録をつける'
    click_on @dammy_name_2
    expect(page).to have_content("体調はどうですか？")
    click_on '変わらない'
    expect(page).to have_content("食欲はありますか？")
    click_on 'あり'
    expect(page).to have_content("睡眠はどうでしたか？")
    click_on '少ない'
    expect(page).to have_content("普段と違うことがあれば")
    click_on '記録する'
  end
end