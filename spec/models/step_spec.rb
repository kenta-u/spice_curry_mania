require 'rails_helper'

RSpec.describe Step, type: :model do
  describe 'validate' do

    it '手順、画像(任意)がある場合、有効である' do
      step = build(:step)
      expect(step).to be_valid
      expect(step.errors).to be_empty
    end

    it '手順があれば、画像(任意)がなくても、有効である' do
      step = build(:step, image: "")
      expect(step).to be_valid
      expect(step.errors).to be_empty
    end

    it '手順がない場合、無効である' do
      step = build(:step, direction: "")
      expect(step).to be_invalid
      expect(step.errors[:direction]).to include("を入力してください")
    end
  end
end
