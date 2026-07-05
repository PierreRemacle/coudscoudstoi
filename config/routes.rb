Rails.application.routes.draw do
  root "patrons#index"

  resource  :session,  only: [ :new, :create, :destroy ]
  resource  :profile,  only: [ :show, :update, :create ]
  get       "profil",       to: "profiles#manage",  as: "manage_profile"
  delete    "profiles/:id", to: "profiles#destroy", as: "destroy_profile"

  resource  :settings, only: [ :show ]
  resources :listes,   only: [ :create, :destroy ]

  resources :patrons do
    resources :notes, only: [ :create, :destroy ]
  end

  resources :marques, only: [ :new, :create, :destroy ]

  get "up" => "rails/health#show", as: :rails_health_check
end
