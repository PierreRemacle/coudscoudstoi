Rails.application.routes.draw do
  root "patrons#index"

  resource  :session, only: [ :new, :create, :destroy ]
  resource  :profile, only: [ :show, :update, :create ]

  resources :patrons do
    resources :notes, only: [ :create, :destroy ]
  end

  resources :marques, only: [ :new, :create ]

  get "up" => "rails/health#show", as: :rails_health_check
end
