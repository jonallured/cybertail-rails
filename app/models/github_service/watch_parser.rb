module GithubService
  class WatchParser < BaseParser
    def able_to_parse?
      @event == 'watch'
    end

    private

    def username
      @params[:sender][:login]
    end

    def message
      "#{username} started watching"
    end

    def url
      @params[:sender][:html_url]
    end
  end
end
