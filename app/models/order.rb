class Order < ApplicationRecord
  before_validation :set_total!

  validates :user_id, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }, presence: true

  belongs_to :user
  has_many :placements
  has_many :toys, through: :placements

  def set_total!
    self.total = toys.map(&:price).sum
  end
end
