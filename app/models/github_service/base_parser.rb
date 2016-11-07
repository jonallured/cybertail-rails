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
        project: project,
        sent_at: Time.now,
        suppress: suppress,
        url: url
      }
    end

    def service
      Service.github
    end

    def project_name
      @params[:repository][:full_name]
    end

    def project
      @project ||= service.projects.find_or_create_by name: project_name
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
