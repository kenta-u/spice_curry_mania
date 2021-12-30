class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  mount_uploader :image, ImageUploader

  def own?(object)
    id == object.user_id
  end

  def favorite(recipe)
    favorite_recipes << recipe
  end

  def unfavorite(recipe)
    favorite_recipes.destroy(recipe)
  end

  def favorite?(recipe)
    favorite_recipes.include?(recipe)
  end
end
