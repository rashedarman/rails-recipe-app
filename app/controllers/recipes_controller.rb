class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    respond_to do |f|
      if @recipe.save
        f.html { redirect_to recipes_path, notice: 'Recipe created' }
      else
        f.html { render :new }
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id]).destroy
    respond_to do |f|
      f.html { redirect_to recipes_path, notice: 'Recipe removed' }
    end
  end

  def my_recipes
    @recipes = current_user.recipes.includes(:user)
  end

  def public_recipes
    @recipes = Recipe.includes(:user).where(public: true).order(created_at: :desc)

    @shopping_lists = {}
    @recipes.each do |recipe|
      @shopping_lists[recipe.id] = generate_shopping_list(recipe)
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to @recipe
  end

  def shopping_list
    @recipe = Recipe.find(params[:id])
    @shopping_list = generate_shopping_list(@recipe)
  end

  def generate_shopping_list(recipe)
    recipe_foods = RecipeFood.where(recipe:)

    shopping_list = {}

    recipe_foods.each do |recipe_food|
      food = Food.find(recipe_food.food_id)
      quantity = recipe_food.quantity
      measurement_unit = food.measurement_unit

      if shopping_list[food.name].nil?
        shopping_list[food.name] =
          { quantity:, measurement_unit:, price: food.price, name: food.name }
      else
        shopping_list[food.name][:quantity] += quantity
        shopping_list[food.name][:price] += food.price
      end
    end

    shopping_list
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
