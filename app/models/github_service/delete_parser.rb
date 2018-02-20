module GithubService
  class DeleteParser < BaseParser
    def able_to_parse?
      @event == 'delete'
    end

    private

    def username
      @params[:sender][:login]
    end

    def type
      @params[:ref_type]
    end

    def name
      @params[:ref]
    end

    def message
      %(#{username} deleted #{type} "#{name}")
    end

    def url
      @params[:repository][:html_url]
    end
  end
end
