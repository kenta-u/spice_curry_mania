class Step < ApplicationRecord
  belongs_to :recipe

  validates :direction, presence: true

  mount_uploader :image, ImageUploader
end
