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
      sent_at: Time.current
    }
  end

  def message
    build_number = @params[:number]
    author_name = @params[:author_name]
    result_message = @params[:result_message].downcase

    "build ##{build_number} by #{author_name} #{result_message}"
  end
end
