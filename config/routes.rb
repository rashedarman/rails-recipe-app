Rails.application.routes.draw do
  devise_for :users

  root "recipes#my_recipes"

  get '/public-recipes', to: 'recipes#public_recipes'
  get '/recipes', to: 'recipes#my_recipes'
  get '/foods', to: 'foods#my_foods'
  get '/recipes/:id/shopping_list', to: 'recipes#shopping_list', as: 'recipe_shopping_list'
  put '/recipes/:id/toggle_public', to: 'recipes#toggle_public', as: 'recipe_toggle_public'

  resources :recipes do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end
  resources :foods, only: [:new, :create, :destroy]
end
