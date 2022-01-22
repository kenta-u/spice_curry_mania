require 'rails_helper'

RSpec.describe Spice, type: :model do
  describe 'validate' do
    it 'スパイス名、分量、スパイスの種類(ホールかパウダーか)がある場合、有効である' do
      spice = build(:spice)
      expect(spice).to be_valid
      expect(spice.errors).to be_empty
    end

    it 'スパイス名がない場合、無効である' do
      spice = build(:spice, name: "")
      expect(spice).to be_invalid
      expect(spice.errors[:name]).to include("を入力してください")
    end

    it '分量がない場合、無効である' do
      spice = build(:spice, quantity: "")
      expect(spice).to be_invalid
      expect(spice.errors[:quantity]).to include("を入力してください")
    end

    it 'スパイスの種類(ホールかパウダーか)がない場合、無効である' do
      spice = build(:spice, classification: "")
      expect(spice).to be_invalid
      expect(spice.errors[:classification]).to include("を入力してください")
    end
  end
end
