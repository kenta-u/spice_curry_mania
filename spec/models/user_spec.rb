require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'validation' do
    it 'ユーザー名、メールアドレス、パスワード、パスワード確認が入力されてる場合、有効である' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it 'ユーザー名がない場合、無効である' do
      user = build(:user, name: "")
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("を入力してください")
    end

    it 'メールアドレスがない場合、無効である' do
      user = build(:user, email: "")
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("を入力してください")
    end

    it 'パスワードが3文字以上でない場合、無効である' do
      user = build(:user, password: "12", password_confirmation: "12")
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("は3文字以上で入力してください")
    end

    it 'パスワードが3文字以上で入力されていても、パスワード確認がない場合無効である' do
      user = build(:user, password_confirmation: "")
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      expect(user.errors[:password_confirmation]).to include("を入力してください")
    end

    it 'パスワードとパスワード確認が一致しない場合無効である' do
      user = build(:user, password: "1234")
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it '重複したメールアドレスの場合、無効である' do
      user = create(:user)
      same_email_user = build(:user, email: user.email)
      expect(same_email_user).to be_invalid
      expect(same_email_user.errors[:email]).to include("はすでに存在します")
    end
  end
end
