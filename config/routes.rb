Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
     resources :available_restaurants, only: :index
    end 
  end 
end
