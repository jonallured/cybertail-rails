class HooksController < ApplicationController
  before_action :verify_signature, only: :github_create

  expose :project, find_by: :token, id: :project_token

  def create
    parser.parse(*args)
    head :created
  end

  def github_create
    hook_attrs = {
      payload: request.body.read,
      sent_at: Time.zone.now,
      project: Service.test.projects.first
    }
    Hook.create! hook_attrs
    head :created
  end

  private

  def verify_signature
    head :not_found unless signatures_match?
  end

  def signatures_match?
    request.body.rewind
    payload_body = request.body.read
    sha1 = OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new('sha1'),
      ENV['HUB_SIGNATURE'],
      payload_body
    )
    signature = 'sha1=' + sha1
    Rack::Utils.secure_compare(signature, hub_signature)
  end

  def hub_signature
    request.headers['X-Hub-Signature']
  end

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
