Rails.application.routes.draw do

  for property_type in PROPERTY_TYPES
    resources "#{property_type.downcase}s".to_sym,
    :controller => "properties", :type => "#{property_type}"
  end

  post   "properties/add_image",           to: "properties#add_image"
  delete "properties/remove_image/:index", to: "properties#remove_image"

  root :to => 'properties#index'
end
