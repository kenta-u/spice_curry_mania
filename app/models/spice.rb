class Spice < ApplicationRecord
  belongs_to :recipe

  enum classification: { whole: 0, powder: 1 }
end
