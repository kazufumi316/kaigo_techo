RSpec.describe '要介護家族新規登録', type: :system do
  describe '要介護家族が新規登録できること' do
    let(:user) { create(:user) }
    it "要介護家族新規登録成功したらホーム画面に遷移すること" do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button "ログイン"
        expect(page).to have_current_path(homes_path, wait: 5)
        click_on '要介護家族情報'
        
        click_on '要介護家族登録'

        dammy_name = Faker::Name.name
        dammy_date = Faker::Date.between(from: '1940-01-01', to: '1960-01-01')
        fill_in 'care_user_name', with: dammy_name
        fill_in 'care_user_birthday', with: dammy_date
        click_on "登録"
        expect(page).to have_current_path(care_users_path, wait: 5)
        expect(page).to have_content(dammy_name)
    end
  end

  describe '要介護家族が新規登録失敗すること' do
    let(:user) { create(:user) }
    it "要介護家族新規登録できないこと" do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button "ログイン"
        expect(page).to have_current_path(homes_path, wait: 5)
        click_on '要介護家族情報'
        
        click_on '要介護家族登録'

        fill_in 'care_user_name', with: ""
        fill_in 'care_user_birthday', with: ""
        click_on "登録"
        expect(page).to have_current_path(new_care_user_path, wait: 5)
    end
  end
end