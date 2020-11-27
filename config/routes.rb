Rails.application.routes.draw do
  devise_for :users, DeviseUser.route_options

  devise_scope :user do
    get 'forgot', to: 'devise/passwords#new', as: :forgot
    get 'sign-in', to: 'devise/sessions#new', as: :sign_in
    get 'sign-out', to: 'devise/sessions#destroy', as: :sign_out
    get 'sign-up', to: 'devise/registrations#new', as: :sign_up
  end

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
