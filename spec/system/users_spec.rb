require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe "ログイン前" do
    describe "ユーザー新規登録" do
      context "フォームの入力値が正常" do
        it "ユーザー登録が成功する" do
          visit new_user_path
          fill_in "ユーザー名", with: "test_user"
          fill_in "メールアドレス", with: "test_user@example.com"
          fill_in "パスワード", with: "12345678"
          fill_in "パスワード確認", with: "12345678"
          click_button "登録"
          expect(page).to have_content "ユーザー登録が完了しました"
          expect(current_path).to eq login_path
        end
      end

      context 'ユーザー名が未入力' do
        it 'ユーザー登録が失敗する' do
          visit new_user_path
          fill_in "ユーザー名", with: ""
          fill_in "メールアドレス", with: "test_user@example.com"
          fill_in "パスワード", with: "12345678"
          fill_in "パスワード確認", with: "12345678"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(page).to have_content "ユーザー名を入力してください"
          expect(current_path).to eq users_path
        end
      end

      context '登録済みのメールアドレスを使用' do
        it 'ユーザー登録が失敗する' do
          existed_user = create(:user)
          visit new_user_path
          fill_in "ユーザー名", with: "test"
          fill_in "メールアドレス", with: existed_user.email
          fill_in "パスワード", with: "12345678"
          fill_in "パスワード確認", with: "12345678"
          click_button "登録"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(page).to have_content "メールアドレスはすでに存在します"
          expect(current_path).to eq users_path
        end
      end
    end

    describe 'ユーザー詳細ページ' do
      context 'ログインしていない状態' do
        it 'ユーザー詳細ページが表示される' do
          visit user_path(user)
          expect(page).to have_content user.name
          expect(current_path).to eq user_path(user)
        end
      end
    end
  end

  describe "ログイン後" do
    before { login(user) }

    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザー編集が成功する' do
          visit edit_user_path(user)
          fill_in "ユーザー名", with: "update_name"
          fill_in "メールアドレス", with: "update@example.com"
          fill_in "パスワード", with: "12345678"
          fill_in "パスワード確認", with: "12345678"
          click_button "編集"
          expect(page).to have_content "プロフィールを編集しました"
          expect(current_path).to eq root_path
        end
      end

      context 'ユーザー名が未入力' do
        it 'ユーザー編集が失敗する' do
          visit edit_user_path(user)
          fill_in "ユーザー名", with: ""
          fill_in "メールアドレス", with: "update@example.com"
          fill_in "パスワード", with: "12345678"
          fill_in "パスワード確認", with: "12345678"
          click_button "編集"
          expect(page).to have_content "プロフィールの編集に失敗しました"
          expect(page).to have_content "ユーザー名を入力してください"
          expect(current_path).to eq user_path(user)
        end
      end

      context '登録済みのメールアドレスを使用' do
        it 'ユーザー編集が失敗する' do
          visit edit_user_path(user)
          other_user = create(:user)
          fill_in "ユーザー名", with: "update_name"
          fill_in "メールアドレス", with: other_user.email
          fill_in "パスワード", with: "12345678"
          fill_in "パスワード確認", with: "12345678"
          click_button "編集"
          expect(page).to have_content "プロフィールの編集に失敗しました"
          expect(page).to have_content "メールアドレスはすでに存在します"
          expect(current_path).to eq user_path(user)
        end
      end

      context '他ユーザーの編集ページにアクセス' do
        let!(:other_user) { create(:user) }

        it '編集ページへのアクセスが失敗する' do
          visit edit_user_path(other_user)
          expect(page).to have_content "そのページにはアクセスできません"
          expect(current_path).to eq root_path
        end
      end
    end

    describe 'ユーザー詳細ページ' do
      context 'レシピを作成する' do
        it '新規作成したレシピが表示される' do
          recipe = create(:recipe, user: user)
          visit user_path(user)
          expect(page).to have_content recipe.name
          expect(page).to have_content user.name
        end
      end
    end
  end
end
