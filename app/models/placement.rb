class Placement < ApplicationRecord
  belongs_to :order, inverse_of: :placements
  belongs_to :toy, inverse_of: :placements

  after_create :decrement_toy_quantity!

  def decrement_toy_quantity!
    self.toy.decrement! :quantity, quantity
  end
end
