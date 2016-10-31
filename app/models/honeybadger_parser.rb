class HoneybadgerParser
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
      service: Service.honeybadger,
      payload: @params,
      project: project,
      message: message,
      url: fault[:url],
      sent_at: Time.now
    }
  end

  def project
    @params[:project][:name]
  end

  def message
    "#{fault[:klass]}: #{fault[:message]}"
  end

  def fault
    @params[:fault]
  end
end
