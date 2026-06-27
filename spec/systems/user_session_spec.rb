require 'rails_helper'

RSpec.describe 'ユーザーログイン', type: :system do
  describe 'ログイン失敗' do
    it "ログイン失敗時にアラートが出ること" do
      visit new_user_session_path
      click_button "ログイン"
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
        click_button "ログイン"
      expect(page).to have_content "メールアドレスまたは\nパスワードが違います"
      expect(current_path).to eq new_user_session_path
    end
  end

    describe 'ログイン成功' do
      let(:user) { create(:user) }
      it "ログインが成功しホーム画面に遷移すること" do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button "ログイン"
        expect(page).to have_current_path(homes_path, wait: 5)
        expect(page).to have_content "ログインしました"
      end
    end
end
