class TravisParser
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
      service: Service.travis,
      payload: @params,
      project: project,
      message: message,
      url: @params[:build_url],
      sent_at: Time.now
    }
  end

  def repository
    @params[:repository]
  end

  def project
    [repository[:owner_name], repository[:name]].join('/')
  end

  def message
    "build ##{@params[:number]} by #{@params[:author_name]} #{@params[:result_message].downcase}"
  end
end
