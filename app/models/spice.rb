class Spice < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true
  validates :quantity, presence: true
  validates :classification, presence: true

  enum classification: { whole: 0, powder: 1 }
end
