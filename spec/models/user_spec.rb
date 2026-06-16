require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    it "アカウント登録ができること" do
      user = build(:user)
      user.valid?
      expect(user.errors[:name]).not_to include("を入力してください")
      expect(user.errors[:tel_number]).not_to include("を入力してください")
      expect(user.errors[:email]).not_to include("を入力してください")
      expect(user.errors[:password]).not_to include("を入力してください")
    end
  end

    describe '#create' do
    it "バリテーションエラーが出ること" do
      user = build(:user, name: nil, tel_number: nil, email: nil, password: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
      expect(user.errors[:tel_number]).to include("を入力してください")
      expect(user.errors[:email]).to include("を入力してください")
      expect(user.errors[:password]).to include("を入力してください")
    end
  end
end
