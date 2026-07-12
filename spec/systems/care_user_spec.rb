require 'rails_helper'

RSpec.describe '見守り家族登録', type: :system do
  describe '見守り家族の新規登録' do
    include_context "アカウントログイン"
    include_context "見守り家族作成"
    it "見守り家族新規登録成功" do
      expect(page).to have_current_path(care_users_path)
      expect(page).to have_content "見守り家族の登録に成功しました"
    end

    context '見守り家族2人目登録' do
      include_context "見守り家族2人目作成"
      it "見守り家族2人目登録成功" do
        expect(page).to have_current_path(care_users_path)
        expect(page).to have_content "見守り家族の登録に成功しました"
      end
    end
  end
    
  describe '見守り家族の新規登録' do
    include_context "アカウントログイン"
    it '見守り家族新規登録失敗' do       
        click_on '見守り家族登録'
        fill_in 'care_user_name', with: ""
        fill_in 'care_user_birthday', with: ""
        click_on "登録"
        expect(page).to have_current_path(new_care_user_path)
        expect(page).to have_content "入力にエラーがあります"
    end
  end
end

RSpec.describe '見守り家族情報', type: :system do
  describe '見守り家族の情報表示' do
    include_context "アカウントログイン"
    include_context "見守り家族作成"
    it '見守り家情報詳細確認' do
      visit homes_path
      click_on '見守り家族情報'
      expect(page).to have_content(@dammy_name)
      birthday = @dammy_date.strftime('%Y年%-m月%-d日')
      expect(page).to have_content(birthday)
      expect(page).to have_content("A型")
      expect(page).to have_content("病名")
      expect(page).to have_content("招待コード")
    end

    context '見守り家族2人目の情報表示' do
      include_context "見守り家族2人目作成"
      it '見守り家族情報詳細2人目確認' do
        visit homes_path
        click_on '見守り家族情報'
        expect(page).to have_content(@dammy_name_2) 
        click_on @dammy_name_2
        expect(page).to have_content(@dammy_name_2)
        birthday = @dammy_date_2.strftime('%Y年%-m月%-d日')
        expect(page).to have_content(birthday)
        expect(page).to have_content("B型")
        expect(page).to have_content("病名")
        expect(page).to have_content("招待コード")
      end
    end
  end
end

RSpec.describe '見守り家族編集', type: :system do
  describe '見守り家族の情報編集' do
    include_context "アカウントログイン"
    include_context "見守り家族作成"
    it "見守り家情報の編集成功" do
      click_on @dammy_name
      click_on '編集'
      dammy_name = Faker::Name.name
      dammy_date = Faker::Date.between(from: '1940-01-01', to: '1960-01-01')
      fill_in 'care_user_name', with: dammy_name
      fill_in 'care_user_birthday', with: dammy_date
      select 'B型', from: 'care_user_blood_type'
      click_on '更新'
      expect(page).to have_current_path(care_users_path)
      expect(page).to have_content "見守り家族情報を\n更新しました"
    end
  end

  describe '見守り家族の情報編集' do
    include_context "アカウントログイン"
    include_context "見守り家族作成"
    it "見守り家族情報の更新失敗" do
      click_on @dammy_name
      click_on '編集'
      fill_in 'care_user_name', with: ""
      click_on '更新'
      expect(page).to have_current_path(%r{/care_users/\d+})
      expect(page).to have_content "見守り家族の更新に\n失敗しました"
    end
  end

  describe '見守り家族の削除' do
    include_context "アカウントログイン"
    include_context "見守り家族作成"
    it "見守り家族削除成功" do
    click_on @dammy_name
      accept_confirm(wait: 5) do
        click_on "見守り家族削除"
      end
      expect(page).to have_current_path(homes_path)
      expect(page).to have_content "見守り家族のアカウントを\n削除しました"
    end
  end
end