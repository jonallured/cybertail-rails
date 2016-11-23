class HooksController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    project = Project.find_by token: params[:project_token]

    if project.service == Service.circle
      CircleParser.parse(params)
    elsif project.service == Service.heroku
      HerokuParser.parse(params)
    elsif project.service == Service.honeybadger
      HoneybadgerParser.parse(params)
    elsif project.service == Service.travis
      TravisParser.parse(params)
    elsif project.service == Service.github
      GithubService.parse(github_event, params)
    end

    head :created
  end

  private

  def github_event
    request.headers['X-GitHub-Event']
  end
end
