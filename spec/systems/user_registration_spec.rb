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
      expect(page).to have_content "アカウント登録が完了しました"
    end
  end

  describe 'アカウント編集成功' do
    it "アカウント編集が成功しホーム画面に遷移すること" do
      visit new_user_registration_path
      fill_in '氏名', with: Faker::Name.name
      fill_in '電話番号', with: Faker::PhoneNumber.phone_number
      fill_in 'メールアドレス', with: Faker::Internet.email
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_button "登録"
      expect(page).to have_current_path(homes_path, wait: 5)
      click_on "アカウント情報"
      click_on "編集"
      fill_in '氏名', with: '権蔵'
      fill_in '電話番号', with: '020000000'
      fill_in 'メールアドレス', with: 'fake@fake.com'
      fill_in 'パスワード', with: 'password1'
      fill_in 'パスワード（確認用）', with: 'password1'
      click_button "更新"
      expect(page).to have_current_path(homes_path, wait: 5)
      expect(page).to have_content "アカウント情報を更新しました"
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
      expect(page).to have_content "入力にエラーがあります"
    end
  end

  describe 'アカウント編集失敗' do
    it "アカウント編集が失敗すること" do
      visit new_user_registration_path
      fill_in '氏名', with: Faker::Name.name
      fill_in '電話番号', with: Faker::PhoneNumber.phone_number
      fill_in 'メールアドレス', with: Faker::Internet.email
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_button "登録"
      expect(page).to have_current_path(homes_path, wait: 5)
      click_on "アカウント情報"
      click_on "編集"
      fill_in '氏名', with: ""
      fill_in '電話番号', with: ""
      fill_in 'メールアドレス', with: ""
      click_button "更新"
      expect(current_path).to eq edit_user_registration_path
      expect(page).to have_content "入力にエラーがあります"
    end
  end
end