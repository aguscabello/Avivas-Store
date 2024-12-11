class Sale < ApplicationRecord
  belongs_to :user
  has_many :sold_products, dependent: :destroy
  has_many :products, through: :sold_products

  validates :client_name, :date, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :sold_products, allow_destroy: true
  before_validation :calculate_total
  after_destroy :restore_stock_if_canceled



  def calculate_total
    self.total = sold_products.includes(:product).sum do |sold_product|
      sold_product.quantity * sold_product.product.price
    end
  end

  def cancel!
    return if canceled?

    ActiveRecord::Base.transaction do
      update!(canceled: true)
      restore_stock_if_canceled
    end
  end


  private

  def restore_stock_if_canceled
    return unless canceled?

    sold_products.each do |sold_product|
      product = sold_product.product
      product.update(stock: product.stock + sold_product.quantity)
    end
  end
end
