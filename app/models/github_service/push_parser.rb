module GithubService
  class PushParser < BaseParser
    def able_to_parse?
      @event == 'push'
    end

    private

    def username
      @params[:pusher][:name]
    end

    def commit_count
      @params[:commits].count
    end

    def ref
      @params[:ref].split("/").last
    end

    def message
      "#{username} pushed #{commit_count} commits to #{ref}"
    end

    def url
      @params[:compare]
    end
  end
end
