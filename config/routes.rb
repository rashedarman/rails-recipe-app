Rails.application.routes.draw do
  root "foods#index"
  devise_for :users
  resources :foods
end
