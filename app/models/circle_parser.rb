class CircleParser
  def self.parse(params, project)
    new(params, project).parse
  end

  def initialize(params, project)
    @params = params[:payload]
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
    "build ##{@params[:build_num]} by #{@params[:committer_name]} #{result}"
  end

  def result_map
    {
      'canceled' => 'canceled',
      'infrastructure_fail' => 'failed',
      'timedout' => 'failed',
      'failed' => 'failed',
      'no_tests' => 'failed',
      'success' => 'passed'
    }
  end

  def result
    outcome = @params[:outcome]
    result_map[outcome]
  end
end
