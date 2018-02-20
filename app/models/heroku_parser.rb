class HerokuParser
  def self.parse(params, project)
    new(params, project).parse
  end

  def initialize(params, project)
    @params = params
    @project = project
  end

  def parse
    Hook.create hook_params
  end

  private

  def hook_params
    {
      payload: @params,
      project: @project,
      message: message,
      url: url,
      sent_at: Time.current
    }
  end

  def message
    "#{@params[:release]} deployed by #{@params[:user]}"
  end

  def url
    "https://dashboard.heroku.com/apps/#{@params[:app]}"
  end
end
