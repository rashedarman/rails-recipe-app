class RecipesController < ApplicationController
  def index
    @recipes = Recipe.includes(:user).all
  end

  def show
    @recipe = Recipe.includes(:recipe_foods, :foods).find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      flash[:success] = 'Recipe added successfully'
      redirect_to @recipe
    else
      flash.now[:error] = 'Failed to add recipe'
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:success] = 'Recipe removed'
    redirect_to recipes_url
  end

  def my_recipes
    @recipes = current_user&.recipes.includes(:user) || []
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
