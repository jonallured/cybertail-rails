class HerokuParser
  def self.parse(params)
    new(params).parse
  end

  def initialize(params)
    @params = params
  end

  def parse
    Hook.create hook_params
  end

  private

  def hook_params
    {
      payload: @params,
      project: project,
      message: message,
      url: url,
      sent_at: Time.now
    }
  end

  def service
    Service.heroku
  end

  def project_name
    @params[:app]
  end

  def project
    @project ||= service.projects.find_or_create_by name: project_name
  end

  def message
    "#{@params[:release]} deployed by #{@params[:user]}"
  end

  def url
    "https://dashboard.heroku.com/apps/#{@params[:app]}"
  end
end
