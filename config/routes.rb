Rails.application.routes.draw do
  resources :property
  root :to => "property#index"
end
