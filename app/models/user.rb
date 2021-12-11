class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :recipes
  has_many :favorites
end
