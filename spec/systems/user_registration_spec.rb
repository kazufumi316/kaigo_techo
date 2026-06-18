require 'rails_helper'

RSpec.describe 'アカウント登録', type: :system do    
  describe 'アカウント登録成功' do
    it "アカウント登録が成功しホーム画面に遷移すること" do
      visit new_user_registration_path
      fill_in '氏名', with: Faker::Name.name
      fill_in '電話番号', with: Faker::PhoneNumber.phone_number
      fill_in 'メールアドレス', with: Faker::Internet.email
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_button "登録"
      expect(page).to have_current_path(homes_path, wait: 5)
    end
  end

  describe 'アカウント登録失敗' do
    it "アカウント登録が失敗すること" do
      visit new_user_registration_path
      fill_in '氏名', with: ""
      fill_in '電話番号', with: ""
      fill_in 'メールアドレス', with: ""
      fill_in 'パスワード', with: ""
      fill_in 'パスワード（確認用）', with: ""
      click_button "登録"
      expect(current_path).to eq new_user_registration_path
    end
  end
end