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
    @recipes = Recipe.includes(recipe_foods: [:food]).where(user: current_user)
    @foods = {}
    @food_count = 0
    @total_cost = 0
    @recipes.each do |r|
      r.recipe_foods.each do |rf|
        name = rf.food.name
        if @foods[name]
          @foods[name] += rf.quantity
        else
          @food_count += 1
          @foods[name] = rf.quantity
        end
      end
      @total_cost += recipe.total_cost_calculator
    end
  end

  def recipe_shopping_list
    @recipe = Recipe.includes(recipe_foods: %i[food]).find_by(id: params[:recipe_id])
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
