Rails.application.routes.draw do
  resources :houses, :controller => "properties", :type => "House"

  root :to => 'properties#index'
end
