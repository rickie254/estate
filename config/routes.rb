Rails.application.routes.draw do

  for property_type in PROPERTY_TYPES
    resources "#{property_type.downcase}s".to_sym,
    :controller => "properties", :type => "#{property_type}"
  end

  post "properties/add_image", to: "properties#update_gallery"

  root :to => 'properties#index'
end
