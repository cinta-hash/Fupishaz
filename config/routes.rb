Rails.application.routes.draw do
 
  resources :links, only: [:create, :show]
  get '/:short_url', to: 'links#redirect'

  get "up" => "rails/health#show", as: :rails_health_check

  
end
