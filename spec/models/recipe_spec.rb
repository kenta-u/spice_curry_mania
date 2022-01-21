require 'rails_helper'

RSpec.describe Recipe, type: :model do

  describe 'validation' do
    it 'レシピ名、何人分、種類、レシピ画像が入力されている場合、有効である' do
      recipe = build(:recipe)
      expect(recipe).to be_valid
      expect(recipe.errors).to be_empty
    end

    it 'レシピ名がない場合、無効である' do
      recipe = build(:recipe, name: "")
      expect(recipe).to be_invalid
      expect(recipe.errors[:name]).to include("を入力してください")
    end

    it '何人分がない場合、無効である' do
      recipe = build(:recipe, survings: "")
      expect(recipe).to be_invalid
      expect(recipe.errors[:survings]).to include("を入力してください")
    end

    it '種類がない場合、無効である' do
      recipe = build(:recipe, category: "")
      expect(recipe).to be_invalid
      expect(recipe.errors[:category]).to include("を入力してください")
    end

    it 'レシピ画像がない場合、無効である' do
      recipe = build(:recipe, image: "")
      expect(recipe).to be_invalid
      expect(recipe.errors[:image]).to include("を入力してください")
    end
  end
end
