Rails.application.routes.draw do

  devise_for :admins,
  path: 'admin',
  path_names:
  {
    sign_in: 'entrar',
    sign_out: 'sair',
    password: 'senha',
  }

  resources :properties, only: :destroy

  for type in PROPERTY_TYPES
    get   "#{I18n.t "routes.#{type}.other"}",          to: "properties#index",  as: "#{type.downcase}s".to_sym, type: "#{type}"
    get   "vendas/#{I18n.t "routes.#{type}.other"}",   to: "properties#index",  as: "sale_#{type.downcase}s".to_sym,  type: "#{type}", deal: :sale
    get   "aluguel/#{I18n.t "routes.#{type}.other"}",  to: "properties#index",  as: "rent_#{type.downcase}s".to_sym, type: "#{type}", deal: :rent

    get   "#{I18n.t "routes.#{type}.one"}/:id/",       to: "properties#show",  as: "#{type.downcase}".to_sym,      type: "#{type}"
    get   "novo/#{I18n.t "routes.#{type}.one"}",       to: "properties#new",   as: "new_#{type.downcase}".to_sym,  type: "#{type}"
    get   "editar/#{I18n.t "routes.#{type}.one"}/:id", to: "properties#edit",  as: "edit_#{type.downcase}".to_sym, type: "#{type}"
    post  "#{I18n.t "routes.#{type}.other"}",          to: "properties#create", type: "#{type}"
    patch "#{I18n.t "routes.#{type}.one"}/:id",        to: "properties#update", type: "#{type}"
  end

  resources :customer_properties, except: :new do
    get "read", to: "customer_properties#read"
  end

  get "avaliamos_seu_imovel", to: "customer_properties#new", as: :new_customer_property

  get "imoveis", to: "properties#index", as: :properties

  get    "properties/get_images/",            to: "properties#get_images"
  post   "properties/add_image/",             to: "properties#add_image"
  get    "properties/set_main_image/:index",  to: "properties#set_main_image"
  delete "properties/remove_image/:index",    to: "properties#remove_image"

  get    "properties/get_extra_list/",     to: "properties#get_extra_list"
  post   "properties/add_extra/",          to: "properties#add_extra"
  delete "properties/remove_extra/:index", to: "properties#remove_extra"

  post   "questions",             to: "questions#create"
  get    "utils/get_stats/",      to: "utils#get_stats"
  get    "utils/get_available_properties/",      to: "utils#get_available_properties"

  root :to => 'properties#home'
end
