Rails.application.routes.draw do

  for property_type in PROPERTY_TYPES
    resources "#{property_type.downcase}s".to_sym,
    :controller => "properties", :type => "#{property_type}"
  end

  get    "properties/get_images/",          to: "properties#get_images"
  post   "properties/add_image/",           to: "properties#add_image"
  delete "properties/remove_image/:index",  to: "properties#remove_image"

  root :to => 'properties#home'
end
