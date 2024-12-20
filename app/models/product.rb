class Product < ApplicationRecord
  acts_as_paranoid
  belongs_to :category
  belongs_to :color, optional: true

  has_rich_text :description
  has_many_attached :images, dependent: :nullify
  has_many :sold_products
  has_many :sales, through: :sold_products



  def self.ransackable_attributes(auth_object = nil)
    %w[name category_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category color rich_text_description]
  end


  validates :name, :description, :price, :stock, :category,  presence: true
  validates :images, presence: true, on: :create
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
end
