Rails.application.routes.draw do
  scope module: 'api', constraints: { subdomain: 'api' } do
    namespace 'v1' do
      get '/hooks/', to: 'hooks#index'
      get '/authenticate', to: 'authenticate#show'
    end
  end

  constraints subdomain: 'hooks' do
    post '/v1/:project_token', to: 'hooks#create'
  end

  post 'circle_hooks', to: 'circle_hooks#create'
  post 'github_hooks', to: 'github_hooks#create'
  post 'heroku_hooks', to: 'heroku_hooks#create'
  post 'honeybadger_hooks', to: 'honeybadger_hooks#create'
  post 'travis_hooks', to: 'travis_hooks#create'
end
