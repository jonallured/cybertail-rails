Rails.application.routes.draw do
  constraints subdomain: 'hooks' do
    post '/v1/:project_token', to: 'hooks#create'
  end

  post 'circle_hooks', to: 'circle_hooks#create'
  post 'github_hooks', to: 'github_hooks#create'
  post 'heroku_hooks', to: 'heroku_hooks#create'
  post 'honeybadger_hooks', to: 'honeybadger_hooks#create'
  post 'travis_hooks', to: 'travis_hooks#create'

  get 'v1/hooks/', to: 'api/v1/hooks#index'
  get 'v1/authenticate', to: 'api/v1/authenticate#show'
end
