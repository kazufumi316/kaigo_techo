require 'rails_helper'

RSpec.describe 'マイページ', type: :system do
  describe 'マイページに遷移' do
    let(:user) { create(:user) }
    it "マイページに遷移できること" do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button "ログイン"
        expect(page).to have_current_path(homes_path, wait: 5)
        click_on 'マイページ'
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.tel_number)
        expect(page).to have_content(user.email)
        click_on "戻る"
        expect(page).to have_current_path(homes_path, wait: 5)
    end
  end
end