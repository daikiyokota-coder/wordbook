require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe 'バリデーション' do
    it 'nameとpasswordどちらも値が設定されていれば、OK' do
      expect(@user.valid?).to eq(true)
    end

    it 'nameが空だとNG' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
    end

    it 'passwordが空だとNG' do
      @user.password_digest = ''
      expect(@user.valid?).to eq(false)
    end

    it '同じ名前のユーザーは作れない' do
      User.create(name: 'hogehoge', password: 'password')
      @user.name = 'hogehoge'
      expect(@user.valid?).to eq(false)
    end
  end
end
