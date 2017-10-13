Rails.application.routes.draw do

  for property_type in PROPERTY_TYPES
    resources "#{property_type.downcase}s".to_sym,
    :controller => "properties", :type => "#{property_type}" do
    end
  end

  post "properties/add_images", to: "properties#update_gallery"

  root :to => 'properties#index'
end
