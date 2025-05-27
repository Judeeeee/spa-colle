Rails.application.routes.draw do
  root "pages#index"
  get "/facilities/map", to: "maps#index"
  resources :facilities, only: [ :index, :show ] do
    resources :checkin_logs, only: [ :index, :create ]
  end
  resources :users, only: [ :show, :destroy ]
  get "/terms", to: "pages#terms"
  get "/privacy", to: "pages#privacy"
  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: "sessions#failure"
  get "log_out", to: "sessions#destroy", as: "log_out"
end
