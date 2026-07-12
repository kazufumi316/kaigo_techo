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
    expect(page).to have_current_path(care_users_path)
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
    expect(page).to have_current_path(care_users_path)
  end
end