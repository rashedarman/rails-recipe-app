class Food < ApplicationRecord
  belongs_to :user

  validates :name, :measurement_unit, :price, :quantity, presence: true
end
