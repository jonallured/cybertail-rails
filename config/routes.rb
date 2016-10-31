Rails.application.routes.draw do
  post 'github_hooks', to: 'github_hooks#create'
  post 'heroku_hooks', to: 'heroku_hooks#create'
  post 'honeybadger_hooks', to: 'honeybadger_hooks#create'
  post 'travis_hooks', to: 'travis_hooks#create'
  get 'v1/hooks/', to: 'api/v1/hooks#index'
end
