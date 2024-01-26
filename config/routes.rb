Rails.application.routes.draw do
 
  post '/create', to: 'links#create'
  get '/:short_code', to: 'links#redirect'

end
