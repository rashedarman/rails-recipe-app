Rails.application.routes.draw do
  root "recipes#index"
  get 'my-recipes', to: 'recipes#my_recipes'

  devise_for :users
  resources :recipes
  resources :foods
end
