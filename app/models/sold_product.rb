class SoldProduct < ApplicationRecord
  belongs_to :sale
  belongs_to :product
  validates :quantity, :price, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  validate :stock_available
  before_validation :set_price, if: :product_id_changed?


  private

  def stock_available
    errors.add(:quantity, "is more than available stock") if product.stock < quantity
  end

  def set_price
    self.price = product.price if product
  end
end
