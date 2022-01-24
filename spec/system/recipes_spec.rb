require 'rails_helper'

RSpec.describe "Recipes", type: :system do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context '新規レシピ投稿ページにアクセス' do
        it '新規レシピ投稿ページへのアクセスが失敗する' do
          visit new_recipe_path
          expect(page).to have_content "ログインが必要です"
          expect(current_path).to eq login_path
        end
      end

      context 'レシピ編集ページにアクセス' do
        it 'レシピ編集ページへのアクセスが失敗する' do
          visit edit_recipe_path(recipe)
          expect(page).to have_content "ログインが必要です"
          expect(current_path).to eq login_path
        end
      end

      context 'レシピ詳細ページにアクセス' do
        it 'レシピ詳細ページが表示される' do
          visit recipe_path(recipe)
          expect(page).to have_content recipe.name
          expect(current_path).to eq recipe_path(recipe)
        end
      end

      context 'レシピ一覧ページにアクセス(root_path)' do
        it 'レシピ一覧ページが表示される' do
          recipe_list = create_list(:recipe, 3)
          visit root_path
          expect(page).to have_content recipe_list[0].name
          expect(page).to have_content recipe_list[1].name
          expect(page).to have_content recipe_list[2].name
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }

    describe 'レシピ新規投稿' do
      context 'フォームの入力値が正常' do
        it 'レシピ新規投稿が成功する' do
          visit new_recipe_path
          fill_in "レシピ名", with: "test_curry"
          fill_in "何人分", with: 2
          select "お肉のカレー", from: "種類"
          recipe_image_path = Rails.root.join('spec/fixtures/test.jpeg')
          attach_file('recipe[image]', recipe_image_path, make_visible: true)
          fill_in "recipe_ingredients_attributes_0_name", with: "ingredient_name"
          fill_in "recipe_ingredients_attributes_0_quantity", with: "ingredient_quantity"
          fill_in "recipe_spices_attributes_0_name", with: "spice_name"
          fill_in "recipe_spices_attributes_0_quantity", with: "spice_quantity"
          select "ホール", from: "recipe_spices_attributes_0_classification"
          fill_in "手順", with: "test_step"
          step_image_path = Rails.root.join('spec/fixtures/sample_step.jpeg')
          attach_file('recipe[steps_attributes][0][image]', step_image_path, make_visible: true)
          click_button "レシピを投稿"
          expect(page).to have_content "レシピを作成しました"
          expect(page).to have_content "test_curry"
          expect(current_path).to eq root_path
        end
      end

      context 'レシピ名が未入力' do
        it 'レシピ新規投稿が失敗する' do
          visit new_recipe_path
          fill_in "レシピ名", with: ""
          fill_in "何人分", with: 2
          select "お肉のカレー", from: "種類"
          recipe_image_path = Rails.root.join('spec/fixtures/test.jpeg')
          attach_file('recipe[image]', recipe_image_path, make_visible: true)
          fill_in "recipe_ingredients_attributes_0_name", with: "ingredient_name"
          fill_in "recipe_ingredients_attributes_0_quantity", with: "ingredient_quantity"
          fill_in "recipe_spices_attributes_0_name", with: "spice_name"
          fill_in "recipe_spices_attributes_0_quantity", with: "spice_quantity"
          select "ホール", from: "recipe_spices_attributes_0_classification"
          fill_in "手順", with: "test_step"
          step_image_path = Rails.root.join('spec/fixtures/sample_step.jpeg')
          attach_file('recipe[steps_attributes][0][image]', step_image_path, make_visible: true)
          click_button "レシピを投稿"
          expect(page).to have_content "レシピの作成に失敗しました"
          expect(current_path).to eq recipes_path
        end
      end
    end

    describe 'レシピ編集' do
      let!(:recipe) { create(:recipe_with_all, user: user) }
      before { visit edit_recipe_path(recipe) }

      context 'フォームの入力値が正常' do
        it 'レシピの編集が成功する' do
          fill_in "レシピ名", with: "edit_curry"
          fill_in "何人分", with: 2
          select "お肉のカレー", from: "種類"
          recipe_image_path = Rails.root.join('spec/fixtures/test.jpeg')
          attach_file('recipe[image]', recipe_image_path, make_visible: true)
          fill_in "recipe_ingredients_attributes_0_name", with: "ingredient_name"
          fill_in "recipe_ingredients_attributes_0_quantity", with: "ingredient_quantity"
          fill_in "recipe_spices_attributes_0_name", with: "spice_name"
          fill_in "recipe_spices_attributes_0_quantity", with: "spice_quantity"
          select "ホール", from: "recipe_spices_attributes_0_classification"
          fill_in "手順", with: "test_step"
          step_image_path = Rails.root.join('spec/fixtures/sample_step.jpeg')
          attach_file('recipe[steps_attributes][0][image]', step_image_path, make_visible: true)
          click_button "レシピを編集"
          expect(page).to have_content "レシピを編集しました"
          expect(page).to have_content "edit_curry"
          expect(current_path).to eq root_path
        end
      end

      context 'レシピ名が未入力' do
        it 'レシピ編集が失敗する' do
          fill_in "レシピ名", with: ""
          fill_in "何人分", with: 2
          select "お肉のカレー", from: "種類"
          recipe_image_path = Rails.root.join('spec/fixtures/test.jpeg')
          attach_file('recipe[image]', recipe_image_path, make_visible: true)
          fill_in "recipe_ingredients_attributes_0_name", with: "ingredient_name"
          fill_in "recipe_ingredients_attributes_0_quantity", with: "ingredient_quantity"
          fill_in "recipe_spices_attributes_0_name", with: "spice_name"
          fill_in "recipe_spices_attributes_0_quantity", with: "spice_quantity"
          select "ホール", from: "recipe_spices_attributes_0_classification"
          fill_in "手順", with: "test_step"
          step_image_path = Rails.root.join('spec/fixtures/sample_step.jpeg')
          attach_file('recipe[steps_attributes][0][image]', step_image_path, make_visible: true)
          click_button "レシピを編集"
          expect(page).to have_content "レシピの編集に失敗しました"
          expect(current_path).to eq recipe_path(recipe)
        end
      end

      context '他ユーザーのレシピ編集ページにアクセス' do
        let!(:other_user) { create(:user) }
        let!(:other_recipe) { create(:recipe, user: other_user) }

        it 'レシピ編集ページへのアクセスが失敗する' do
          visit edit_recipe_path(other_recipe)
          expect(page).to have_content "そのページにはアクセスできません"
          expect(current_path).to eq root_path
        end
      end
    end

    describe 'レシピ削除' do
      let!(:recipe) { create(:recipe, user: user) }

      it 'レシピの削除が成功する' do
        visit recipe_path(recipe)
        click_link "このレシピを削除する"
        expect(page).to have_content "レシピを削除しました"
        expect(page).not_to have_content recipe.name
        expect(current_path).to eq root_path
      end
    end
  end 
end
