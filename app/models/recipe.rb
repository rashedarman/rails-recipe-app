class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, presence: true

  def total_cost_calculator
    total_cost = 0
    recipe_foods.each do |rf|
      total_cost += rf.quantity * rf.food.price
    end
    total_cost
  end
end
