class FoodsController < ApplicationController
  def index
    @user = current_user
    @foods = @user&.foods || []
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params.merge(user: current_user))

    if @food.save
      flash[:success] = 'Food added successfully'
      redirect_to root_path
    else
      flash.now[:error] = 'Failed to add food'
      render :new
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
