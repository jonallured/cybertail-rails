Rails.application.routes.draw do
  scope module: 'api', constraints: { subdomain: 'api' } do
    namespace 'v1' do
      get '/hooks/', to: 'hooks#index'
      get '/authenticate', to: 'authenticate#show'
      patch :users, to: 'users#update'
    end
  end

  constraints subdomain: 'hooks' do
    post '/v1/:project_token', to: 'hooks#create'
  end

  get :ping, to: 'ping#show'
end
