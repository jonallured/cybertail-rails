module GithubService
  class BaseParser
    def initialize(event, params, project)
      @event = event
      @params = params
      @project = project
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
        project: @project,
        sent_at: Time.current,
        suppress: suppress,
        url: url
      }
    end

    def message
      raise 'Implement in subclass'
    end

    def url
      raise 'Implement in subclass'
    end

    def suppress
      false
    end
  end
end
