Rails.application.routes.draw do
  scope module: 'api', constraints: { subdomain: 'api' } do
    namespace 'v1' do
      get '/hooks/', to: 'hooks#index'
      get '/authenticate', to: 'authenticate#show'
      patch :users, to: 'users#update'
    end
  end

  constraints subdomain: 'hooks' do
    post '/', to: 'raw_hooks#create'
  end

  namespace 'admin' do
    resources :providers, only: %i[index show]
    resources :raw_hooks, only: %i[index show]
  end

  get :ping, to: 'ping#show'
end
