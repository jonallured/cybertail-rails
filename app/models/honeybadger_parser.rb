class HoneybadgerParser
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
      url: fault[:url],
      sent_at: Time.now
    }
  end

  def message
    "#{fault[:klass]}: #{fault[:message]}"
  end

  def fault
    @params[:fault]
  end
end
