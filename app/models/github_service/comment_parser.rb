module GithubService
  class CommentParser < BaseParser
    def able_to_parse?
      @event == 'issue_comment'
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
      %Q|#{username} commented on ##{number}: "#{title}"|
    end

    def url
      @params[:comment][:html_url]
    end
  end
end
