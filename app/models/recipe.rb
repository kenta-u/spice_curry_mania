class Recipe < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :spices, dependent: :destory
  has_many :steps, dependent: :destory

  enum category: { meat: 0, fish: 1, vegetable: 2, other: 3 }
end
