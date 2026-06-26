RSpec.describe '介護記録新規登録', type: :system do
  describe '介護記録が新規登録できること' do
    let(:user) { create(:user) }
    it "介護記録新規登録成功したらホーム画面に遷移すること" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_button "ログイン"
      expect(page).to have_current_path(homes_path, wait: 5)
      
      click_on '見守り家族登録'

      dammy_name = Faker::Name.name
      dammy_date = Faker::Date.between(from: '1940-01-01', to: '1960-01-01')
      fill_in 'care_user_name', with: dammy_name
      fill_in 'care_user_birthday', with: dammy_date
      select 'A型', from: 'care_user_blood_type'
      click_on '登録'
      expect(page).to have_current_path(homes_path, wait: 5)
      click_on '記録をつける'
      click_on dammy_name
      click_on '変わらない'
      click_on '変わらない'
      click_on '変わらない'
      click_on '記録する'
      expect(page).to have_current_path(homes_path, wait: 5)
      expect(page).to have_content "介護記録をつけました"
    end
  end

  describe '介護記録が確認ができる' do
    let(:user) { create(:user) }
    it "介護記録一覧ページに遷移できる" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_button "ログイン"
      expect(page).to have_current_path(homes_path, wait: 5)
        
      click_on '見守り家族登録'

      dammy_name = Faker::Name.name
      dammy_date = Faker::Date.between(from: '1940-01-01', to: '1960-01-01')
      fill_in 'care_user_name', with: dammy_name
      fill_in 'care_user_birthday', with: dammy_date
      select 'A型', from: 'care_user_blood_type'
      click_on "登録"
      expect(page).to have_current_path(homes_path, wait: 5)
      click_on '記録をつける'
      click_on dammy_name
      click_on '変わらない'
      click_on '変わらない'
      click_on '変わらない'
      click_on '記録する'
      expect(page).to have_current_path(homes_path, wait: 5)
      click_on '記録を見る'
      click_on dammy_name
      expect(page).to have_content('介護記録一覧')
    end
  end

  describe '介護記録が確認ができる' do
    let(:user) { create(:user) }
    it "介護記録詳細ページに遷移できる" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: 'password'
      click_button "ログイン"
      expect(page).to have_current_path(homes_path, wait: 5)
        
      click_on '見守り家族登録'

      dammy_name = Faker::Name.name
      dammy_date = Faker::Date.between(from: '1940-01-01', to: '1960-01-01')
      fill_in 'care_user_name', with: dammy_name
      fill_in 'care_user_birthday', with: dammy_date
      select 'A型', from: 'care_user_blood_type'
      click_on "登録"
      expect(page).to have_current_path(homes_path, wait: 5)
      click_on '記録をつける'
      click_on dammy_name
      click_on '変わらない'
      click_on '変わらない'
      click_on '変わらない'
      click_on '記録する'
      expect(page).to have_current_path(homes_path, wait: 5)
      click_on '記録を見る'
      click_on dammy_name
      latest_record = CareRecord.last
      target_date = latest_record.created_at.strftime('%-m月%-d日 %-H時%M分')
      click_on target_date
      expect(page).to have_content('介護記録詳細')
    end
  end
end