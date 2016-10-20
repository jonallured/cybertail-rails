module GithubService
  class IssueParser < BaseParser
    def able_to_parse?
      @event == 'issues'
    end

    private

    def username
      @params[:sender][:login]
    end

    def number
      @params[:issue][:number]
    end

    def title
      @params[:issue][:title]
    end

    def message
      %Q|#{username} opened ##{number}: "#{title}"|
    end

    def url
      @params[:issue][:html_url]
    end
  end
end
