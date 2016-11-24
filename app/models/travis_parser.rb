class TravisParser
  def self.parse(params, project)
    new(params, project).parse
  end

  def initialize(params, project)
    parsed = JSON.parse params[:payload]
    @params = ActiveSupport::HashWithIndifferentAccess.new parsed
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
      url: @params[:build_url],
      sent_at: Time.now
    }
  end

  def message
    "build ##{@params[:number]} by #{@params[:author_name]} #{@params[:result_message].downcase}"
  end
end
