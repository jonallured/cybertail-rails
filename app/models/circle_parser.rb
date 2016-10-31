class CircleParser
  def self.parse(params)
    new(params).parse
  end

  def initialize(params)
    parsed = JSON.parse params[:payload]
    @params = ActiveSupport::HashWithIndifferentAccess.new parsed
  end

  def parse
    Hook.create hook_params
  end

  private

  def hook_params
    {
      service: Service.circle,
      payload: @params,
      project: project,
      message: message,
      url: @params[:build_url],
      sent_at: Time.now
    }
  end

  def project
    [@params[:username], @params[:reponame]].join('/')
  end

  def message
    "build ##{@params[:build_num]} by #{@params[:committer_name]} #{@params[:outcome].downcase}"
  end
end
