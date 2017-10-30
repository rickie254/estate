Rails.application.routes.draw do

  for property_type in PROPERTY_TYPES
    resources "#{property_type.downcase}s".to_sym,
    :controller => "properties", :type => "#{property_type}"
  end

  resources :customer_properties

  get    "properties",                        to: "properties#index"

  get    "properties/get_images/",            to: "properties#get_images"
  post   "properties/add_image/",             to: "properties#add_image"
  get    "properties/set_main_image/:index",  to: "properties#set_main_image"
  delete "properties/remove_image/:index",    to: "properties#remove_image"

  get    "properties/get_extra_list/",     to: "properties#get_extra_list"
  post   "properties/add_extra/",          to: "properties#add_extra"
  delete "properties/remove_extra/:index", to: "properties#remove_extra"

  get    "utils/get_stats/",     to: "utils#get_stats"

  root :to => 'properties#home'
end
