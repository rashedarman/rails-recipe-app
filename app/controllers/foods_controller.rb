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

  def edit; end

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

  def update
    if @food.update(food_params)
      flash[:success] = "Successfully updated #{@food}"
      redirect_to user_food_path(@food.user, @food)
    else
      flash.now[:error] = "#{@food} failed to be saved"
      render :edit
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    flash[:success] = 'Food successfully deleted'
    redirect_to root_path
  end

  def general_shopping_list
    @all_foods = Food.all
    @foods = {}
    @food_count = 0
    @total_cost = 0

  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
