require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'いいね機能' do

    context 'いいねできる場合' do
      it 'user_idもrecipe_idもある場合、有効である' do
        favorite = create(:favorite)
        expect(favorite).to be_valid
        expect(favorite.errors).to be_empty
      end

      it 'recipe_idが同じでもuser_idが違う場合、有効である' do
        favorite = create(:favorite)
        another_favorite = create(:favorite, recipe_id: favorite.recipe_id)
        expect(another_favorite).to be_valid
        expect(another_favorite.errors).to be_empty
      end

      it 'user_idが同じでもrecipe_idが違う場合、有効である' do
        favorite = create(:favorite)
        another_favorite = create(:favorite, user_id: favorite.user_id)
        expect(another_favorite).to be_valid
        expect(another_favorite.errors).to be_empty
      end
    end

    context 'いいねできない場合' do
      it 'user_idがない場合、無効である' do
        favorite = create(:favorite)
        favorite.user_id = nil
        expect(favorite).to be_invalid
        expect(favorite.errors[:user]).to include("を入力してください")
      end

      it 'recipe_idがない場合、無効である' do
        favorite = create(:favorite)
        favorite.recipe_id = nil
        expect(favorite).to be_invalid
        expect(favorite.errors[:recipe]).to include("を入力してください")
      end
    end
  end
end
