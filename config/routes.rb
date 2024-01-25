Rails.application.routes.draw do
 
  post '/create', to: 'links#create'
  get '/', to: 'links#redirect'

end
