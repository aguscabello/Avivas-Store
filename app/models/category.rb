class Category < ApplicationRecord
  has_many :products

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w["products"]
  end

  validates :name, presence: true, uniqueness: true
end
