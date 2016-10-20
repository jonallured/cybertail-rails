module GithubService
  class BaseParser
    def initialize(event, params)
      @event = event
      @params = params
    end

    def parse
      Hook.create hook_params
    end

    def able_to_parse?
      raise 'Implement in subclass'
    end

    private

    def hook_params
      {
        message: message,
        payload: @params.to_unsafe_hash,
        project: @params[:repository][:full_name],
        sent_at: Time.now,
        service: Service.github,
        url: url
      }
    end

    def message
      raise 'Implement in subclass'
    end

    def url
      raise 'Implement in subclass'
    end
  end
end
