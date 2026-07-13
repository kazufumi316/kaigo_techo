require 'rails_helper'

RSpec.describe '介護記録作成', type: :system do
  describe '介護記録作成1人の場合' do
    include_context 'アカウントログイン'
    include_context '見守り家族作成'
    include_context '介護記録作成'
    it '介護記録作成成功' do
      expect(page).to have_current_path(homes_path)
      expect(page).to have_content "介護記録をつけました"
    end

    context '介護記録作成2人以上の場合' do
      include_context '見守り家族2人目作成'
      include_context '介護記録作成2人目'
      it '介護記録作成成功' do
        expect(page).to have_current_path(homes_path)
        expect(page).to have_content "介護記録をつけました"
      end
    end
  end

  describe '介護記録作成失敗' do
    include_context 'アカウントログイン'
    include_context '見守り家族作成'
    it '介護記録作成失敗' do
      visit homes_path
      click_on '記録をつける'
      visit memo_care_records_path
      click_on '記録する'
      expect(page).to have_current_path(memo_care_records_path)
      expect(page).to have_content "介護記録が\n作成できませんでした"
    end
  end
end

RSpec.describe '介護記録一覧', type: :system do
  describe '介護記録一覧' do
    include_context 'アカウントログイン'
    include_context '見守り家族作成'
    include_context '介護記録作成'
    it '介護記録一覧1人の場合' do
      click_on '記録を見る'
      expect(page).to have_current_path(%r{/care_records\?care_user_id=\d+})
      expect(page).to have_content('介護記録一覧')
    end

    context '介護記録一覧' do
      include_context '見守り家族2人目作成'
      include_context '介護記録作成2人目'
      it '介護記録一覧2人の場合' do
        click_on '記録を見る'
        click_on @dammy_name_2
        expect(page).to have_current_path(%r{/care_records\?care_user_id=\d+})
        expect(page).to have_content('介護記録一覧')
      end
    end
  end
end

RSpec.describe '介護記録詳細', type: :system do
  describe '介護記録詳細' do
    include_context 'アカウントログイン'
    include_context '見守り家族作成'
    include_context '介護記録作成'
    it '介護記録詳細1人の場合' do
      visit homes_path
      click_on '記録を見る'
      latest_record = CareRecord.last
      target_date = latest_record.created_at.strftime('%-m月%-d日 %-H時%M分')
      click_on target_date
      expect(page).to have_current_path(%r{/care_records/\d+})
      expect(page).to have_content('介護記録詳細')
    end

    context '介護記録詳細' do
      include_context '見守り家族2人目作成'
      include_context '介護記録作成2人目'
      it '介護記録詳細2人の場合' do
        visit homes_path
        click_on '記録を見る'
        click_on @dammy_name_2
        latest_record = CareRecord.last
        target_date = latest_record.created_at.strftime('%-m月%-d日 %-H時%M分')
        click_on target_date
        expect(page).to have_current_path(%r{/care_records/\d+})
        expect(page).to have_content('介護記録詳細')
      end
    end
  end
end

RSpec.describe '介護記録編集', type: :system do
  describe '介護記録編集ができる' do
    include_context 'アカウントログイン'
    include_context '見守り家族作成'
    include_context '介護記録作成'
    it '介護記録編集成功' do
      click_on '記録を見る'
      latest_record = CareRecord.last
      target_date = latest_record.created_at.strftime('%-m月%-d日 %-H時%M分')
      click_on target_date
      click_on '編集'
      select '良い', from: 'care_record_health_status'
      select 'あり', from: 'care_record_appetite'
      select '多い', from: 'care_record_sleep_quality'
      fill_in 'care_record_memo', with: 'こんにちは'
      click_on '更新'
      expect(page).to have_current_path(%r{/care_records/\d+})
      expect(page).to have_content('介護記録を更新しました')
    end
  end
end

RSpec.describe '介護記録削除', type: :system do
  describe '介護記録編集ができる' do
    include_context 'アカウントログイン'
    include_context '見守り家族作成'
    include_context '介護記録作成'
    it '介護記録編集成功' do
      click_on '記録を見る'
      latest_record = CareRecord.last
      target_date = latest_record.created_at.strftime('%-m月%-d日 %-H時%M分')
      click_on target_date
      accept_confirm do
        click_on "介護記録削除"
      end
      expect(page).to have_current_path(%r{/care_records/\d+})
      expect(page).to have_content "#{target_date}\n介護記録を削除しました"
    end
  end
end