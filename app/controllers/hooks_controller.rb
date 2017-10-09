class HooksController < ApplicationController
  expose :project, find_by: :token, id: :project_token

  def create
    parser.parse *args
    head :created
  end

  private

  def parser
    project.service.parser.constantize
  end

  def args
    [github_event, params, project].compact
  end

  def github_event
    request.headers['X-GitHub-Event']
  end
end
