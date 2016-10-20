class GithubHooksController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    GithubService.parse(github_event, params)
    head :created
  end

  private

  def github_event
    request.headers['X-GitHub-Event']
  end
end
