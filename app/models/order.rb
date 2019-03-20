class Order < ApplicationRecord
  before_validation :set_total!

  validates :user_id, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validate :validates_enough_stock

  belongs_to :user
  has_many :placements
  has_many :toys, through: :placements

  def set_total!
    self.total = 0
    placements.each do |placement|
      self.total += placement.toy.price * placement.quantity
    end
  end

  def build_placements(toy_ids_and_quantities)
    toy_ids_and_quantities.each do |(toy_id, quantity)|
      self.placements.build(toy_id: toy_id, quantity: quantity)
    end
  end

  private

  def validates_enough_stock
    placements.each do |placement|
      toy = placement.toy
      errors["#{toy.title}"] << "Stock not enough, only #{toy.quantity} left" if placement.quantity > toy.quantity
    end
  end
end
