Rails.application.routes.draw do

  constraints Clearance::Constraints::SignedIn.new do
    root to: "jobs#index", as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "public#index"
  end

  get 'pricing' => 'public#pricing', as: 'pricing'

  get '/dashboard' => 'jobs#dashboard', as: 'dashboard'

  resources :jobs do
    resources :notes, only: [:index, :create, :destroy, :edit, :update]
    resources :reminders, only: [:create, :destroy]
  end

  resources :settings, only: [:show, :edit, :update, :destroy]
  resources :sources, only: [:edit, :new, :create, :update, :destroy]

  resources :feedbacks, only: [:index, :create, :destroy]

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  get "up" => "rails/health#show", as: :rails_health_check
end
