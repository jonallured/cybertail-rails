class CircleParser
  def self.parse(params)
    new(params).parse
  end

  def initialize(params)
    @params = params[:payload]
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
      url: @params[:build_url],
      sent_at: Time.now
    }
  end

  def service
    Service.circle
  end

  def project_name
    [@params[:username], @params[:reponame]].join('/')
  end

  def project
    @project ||= service.projects.find_or_create_by name: project_name
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
