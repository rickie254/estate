Rails.application.routes.draw do
  get 'admin', to: 'properties#admin'

  # resources :properties, except: :new
  resources :houses, :controller => 'properties'

  root :to => 'properties#index'
end
