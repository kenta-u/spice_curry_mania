class Spice < ApplicationRecord
  belongs_to :recipe

  enum type: { whole: 0, powder: 1 }
end
