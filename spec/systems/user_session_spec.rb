require 'rails_helper'

RSpec.describe 'ユーザーログイン', type: :system do
  describe 'ログイン成功' do
    include_context "アカウントログイン"
    it "ログインが成功しホーム画面に遷移すること" do
      expect(page).to have_current_path(homes_path)
      expect(page).to have_content "ログインしました"
    end
  end

  describe 'ログイン失敗' do
    it "ログイン失敗時にアラートが出ること" do
      visit new_user_session_path
      click_on "ログイン"
      expect(page).to have_content "メールアドレスまたは\nパスワードが違います"
      expect(current_path).to eq new_user_session_path
    end
  end

  describe 'ログイン失敗' do
    let(:user) { create(:user) }
    it "ログインが成功しホーム画面に遷移すること" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'xx@xx.com'
      fill_in 'パスワード', with: 'password'
      click_on "ログイン"
      expect(page).to have_content "メールアドレスまたは\nパスワードが違います"
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'ユーザーログアウト', type: :system do
  describe 'ログアウト成功' do
    include_context "アカウントログイン"
    it "ログアウトが成功しトップ画面に遷移すること" do
      click_on 'ログアウト'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content "ログアウトしました"
    end
  end
end

