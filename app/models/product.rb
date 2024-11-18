class Product < ApplicationRecord
  acts_as_paranoid
  belongs_to :category
  belongs_to :color
  has_rich_text :description
  has_many_attached :images

  validates :name, :description, :price, :stock, :category, :images, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
end
