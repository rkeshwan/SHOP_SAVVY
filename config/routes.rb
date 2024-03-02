Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'dashboard', to: 'pages#dashboard'
  get 'search', to: 'pages#search'
  get 'favourite', to: 'pages#favourite'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :line_items, only: [:destroy] do
    member do
      post :add_item
      post :adjust_item
    end
  end

  resources :grocery_lists, only: [:new, :create, :update, :destroy]
end
