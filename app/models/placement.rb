class Placement < ApplicationRecord
  belongs_to :order, inverse_of: :placements
  belongs_to :toy, inverse_of: :placements
end
