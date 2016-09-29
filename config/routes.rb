Rails.application.routes.draw do
  post :hooks, to: 'hooks#create'
end
