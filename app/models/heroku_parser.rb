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
      service: Service.heroku,
      payload: @params,
      project: @params[:app],
      message: message,
      url: url,
      sent_at: Time.now
    }
  end

  def message
    "#{@params[:release]} deployed by #{@params[:user]}"
  end

  def url
    "https://dashboard.heroku.com/apps/#{@params[:app]}"
  end
end
