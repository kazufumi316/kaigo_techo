RSpec.describe '見守り家族新規登録', type: :system do
  describe '見守り家族が新規登録できること' do
    let(:user) { create(:user) }
    it "見守り家族新規登録成功したら見守り家族一覧に遷移すること" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_on "ログイン"
      expect(page).to have_current_path(homes_path, wait: 5)        
      click_on '見守り家族登録'
      dammy_name = Faker::Name.name
      dammy_date = Faker::Date.between(from: '1940-01-01', to: '1960-01-01')
      fill_in 'care_user_name', with: dammy_name
      fill_in 'care_user_birthday', with: dammy_date
      select 'A型', from: 'care_user_blood_type'
      click_on '登録'
      expect(page).to have_current_path(care_users_path, wait: 5)
      expect(page).to have_content "見守り家族の登録に成功しました"
    end
  end

  describe '見守り家族が新規登録できること' do
    let(:user) { create(:user) }
    it "見守り家族情報を確認できること" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_on "ログイン"
      expect(page).to have_current_path(homes_path, wait: 5)
      click_on '見守り家族登録'
      dammy_name = Faker::Name.name
      dammy_date = Faker::Date.between(from: '1940-01-01', to: '1960-01-01')
      fill_in 'care_user_name', with: dammy_name
      fill_in 'care_user_birthday', with: dammy_date
      select 'A型', from: 'care_user_blood_type'
      click_on '登録'
      expect(page).to have_current_path(care_users_path, wait: 5)
      click_on '戻る'
      click_on '見守り家族情報'
      click_on dammy_name
      expect(page).to have_content("氏名")
      expect(page).to have_content("生年月日")
      expect(page).to have_content("血液型")
      expect(page).to have_content("病名")
      expect(page).to have_content("招待コード")
    end
  end

  describe '見守り家族情報が更新できること' do
    let(:user) { create(:user) }
    it "見守り家族情報が成功したら見守り家族一覧に遷移すること" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_on "ログイン"
      expect(page).to have_current_path(homes_path, wait: 5)
      click_on '見守り家族登録'
      dammy_name = Faker::Name.name
      dammy_date = Faker::Date.between(from: '1940-01-01', to: '1960-01-01')
      fill_in 'care_user_name', with: dammy_name
      fill_in 'care_user_birthday', with: dammy_date
      select 'A型', from: 'care_user_blood_type'
      click_on '登録'
      expect(page).to have_current_path(care_users_path, wait: 5)
      click_on '戻る'
      click_on '見守り家族情報'
      click_on dammy_name
      click_on '編集'
      dammy_name = Faker::Name.name
      dammy_date = Faker::Date.between(from: '1940-01-01', to: '1960-01-01')
      fill_in 'care_user_name', with: dammy_name
      fill_in 'care_user_birthday', with: dammy_date
      select 'B型', from: 'care_user_blood_type'
      click_on '更新'
      expect(page).to have_current_path(care_users_path, wait: 5)
      expect(page).to have_content "見守り家族情報を\n更新しました"
    end
  end

  describe '見守り家族が新規登録失敗すること' do
    let(:user) { create(:user) }
    it "見守り家族新規登録できないこと" do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button "ログイン"
        expect(page).to have_current_path(homes_path, wait: 5)        
        click_on '見守り家族登録'
        fill_in 'care_user_name', with: ""
        fill_in 'care_user_birthday', with: ""
        click_on "登録"
        expect(page).to have_current_path(new_care_user_path, wait: 5)
        expect(page).to have_content "見守り家族の登録に\n失敗しました"
    end
  end

  describe '見守り家族情報の更新に失敗' do
    let(:user) { create(:user) }
    it "見守り家族情報の更新に失敗すること" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_on "ログイン"
      expect(page).to have_current_path(homes_path, wait: 5)
      click_on '見守り家族登録'
      dammy_name = Faker::Name.name
      dammy_date = Faker::Date.between(from: '1940-01-01', to: '1960-01-01')
      fill_in 'care_user_name', with: dammy_name
      fill_in 'care_user_birthday', with: dammy_date
      select 'A型', from: 'care_user_blood_type'
      click_on '登録'
      expect(page).to have_current_path(care_users_path, wait: 5)
      click_on '戻る'
      click_on '見守り家族情報'
      click_on dammy_name
      click_on '編集'
      fill_in 'care_user_name', with: ""
      click_on '更新'
      expect(page).to have_current_path(%r{/care_users/\d+})
      expect(page).to have_content "見守り家族の更新に\n失敗しました"
    end
  end
end