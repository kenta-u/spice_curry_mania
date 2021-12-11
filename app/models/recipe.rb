class Recipe < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :ingredients
  has_many :spices
  has_many :steps
end
