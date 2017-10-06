Rails.application.routes.draw do
  get "admin", to: 'property#admin'
  
  resources :property
  root :to => "property#index"
end
