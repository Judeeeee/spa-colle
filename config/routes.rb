Rails.application.routes.draw do
  root "pages#index"

  resources :facilities, only: [ :index, :show ] do
    get "map", to: "maps#index", on: :collection
    resources :checkin_logs, only: [ :index, :create ]
  end

  resources :users, only: [ :show, :destroy ]

  get "/terms", to: "pages#terms"
  get "/privacy", to: "pages#privacy"

  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: "sessions#failure"
  get "log_out", to: "sessions#destroy", as: "log_out"
end
