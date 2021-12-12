class Recipe < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :ingredients
  has_many :spices
  has_many :steps

  enum category: { meat: 0, fish: 1, vegetable: 2, other: 3 }
end
