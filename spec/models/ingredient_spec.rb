require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'validate' do
    it '材料名と分量がある場合、有効である' do
      ingredient = build(:ingredient)
      expect(ingredient).to be_valid
      expect(ingredient.errors).to be_empty
    end

    it '材料名がない場合、無効である' do
      ingredient = build(:ingredient, name: "")
      expect(ingredient).to be_invalid
      expect(ingredient.errors[:name]).to include("を入力してください")
    end

    it '分量がない場合、無効である' do
      ingredient = build(:ingredient, quantity: "")
      expect(ingredient).to be_invalid
      expect(ingredient.errors[:quantity]).to include("を入力してください")
    end
  end
end
