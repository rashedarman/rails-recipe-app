class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params.merge(user: current_user))
    respond_to do |f|
      if @food.save
        f.html { redirect_to foods_path, notice: 'Food added' }
      else
        f.html { render :new, notice: 'Failed to add food' }
      end
    end
  end

  def destroy
    @food = Food.find(params[:id]).destroy
    respond_to do |f|
      f.html { redirect_to foods_path, notice: 'Food deleted' }
    end
  end

  def my_foods
    @foods = current_user.foods.includes(:user)
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
