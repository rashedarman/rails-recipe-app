class RecipeFoodsController < ApplicationController
    def new
        @recipes = current_user.recipes
        @recipe = @recipes.find(params[:recipe_id]) if params[:recipe_id].present?
        @recipe_food = RecipeFood.new
        @all_foods = Food.all
        @foods = @all_foods.map { |food| [food.name, food.id] }
      end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)

     if @recipe_food.save
      flash[:success] = 'Recipe food added successfully'
      redirect_to recipe_path(@recipe)
    else
      flash.now[:error] = 'Failed to add recipe food'
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])

    if @recipe_food.update(recipe_food_params)
      flash[:success] = 'Recipe food updated successfully'
      redirect_to recipe_path(@recipe)
    else
      flash.now[:error] = 'Failed to update recipe food'
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    @recipe_food.destroy
    flash[:success] = 'Recipe food removed'
    redirect_to recipe_path(@recipe)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
