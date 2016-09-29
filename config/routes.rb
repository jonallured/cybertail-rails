Rails.application.routes.draw do
  post :hooks, to: 'hooks#create'
  get 'v1/hooks/', to: 'api/v1/hooks#index'
end
