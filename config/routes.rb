Rails.application.routes.draw do
  get "users/show"
  devise_for :users

  devise_scope :users do
    get '/users', to: redirect("/users/sign_up")
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :homes, only: [:index]
  resources :users, only: [:show]
  resources :care_users, only: [:index, :new, :create]
  resources :care_records, only: [:index, :create] do
    collection do
      get :create_select_care_user
      patch :save_create_select_care_user
      get :health_status
      patch :save_health_status
      get :appetite
      patch :save_appetite
      get :sleep_quality
      patch :save_sleep_quality
      get :memo
      get :view_select_care_user
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
  root 'static_pages#top'
end
