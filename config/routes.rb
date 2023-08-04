Rails.application.routes.draw do
  root "recipes#index"
  get 'my-recipes', to: 'recipes#my_recipes'
  get 'general_shopping_list', to: 'foods#general_shopping_list'

  devise_for :users
  resources :foods
  resources :recipes do
    resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
  end
end
