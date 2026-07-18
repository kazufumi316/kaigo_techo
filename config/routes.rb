Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get "users/show"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  devise_scope :users do
    get "/users", to: redirect("/users/sign_up")
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :homes, only: [ :index ]
  resources :users, only: [ :show ]
  resources :care_users, only: [ :index, :new, :create, :show, :edit, :update, :destroy ]
  resources :care_records, only: [ :index, :create, :show, :edit, :update, :destroy ] do
    collection do
      get :save_day
      patch :save_save_day
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
  resources :connect_care_users, only: [ :new, :create ]

  namespace :admin do
    root to: "dashboard#index"
    resources :users, only: [ :index, :show, :destroy ]
    resources :care_users, only: [ :index, :show, :destroy ]
    resources :care_records, only: [ :index, :show, :destroy ]
  end

  get "terms_of_service", to: "static_pages#terms_of_service"

  # Defines the root path route ("/")
  # root "articles#index"
  root "static_pages#top"
end
