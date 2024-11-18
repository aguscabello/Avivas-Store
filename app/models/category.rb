class Category < ApplicationRecord
  has_many :products

  validates :name, presense: true, uniqueness: true
end
