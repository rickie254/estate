Rails.application.routes.draw do
  resources :houses, :controller => "properties", :type => "House" do
    resources :images, :only => [:create, :destroy]
  end

  root :to => 'properties#index'
end
