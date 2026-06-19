Rails.application.routes.draw do
  get "users/show"
  devise_for :users

  devise_scope :users do
    get '/users', to: redirect("/users/sign_up")
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :homes, only: [:index]
  resources :users, only: [:show]

  # Defines the root path route ("/")
  # root "articles#index"
  root 'static_pages#top'
end
