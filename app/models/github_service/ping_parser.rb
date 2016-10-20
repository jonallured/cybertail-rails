module GithubService
  class PingParser < BaseParser
    def able_to_parse?
      @event == 'ping'
    end

    private

    def message; end

    def url; end

    def suppress
      true
    end
  end
end
