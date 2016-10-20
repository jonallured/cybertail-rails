module GithubService
  class CreateParser < BaseParser
    def able_to_parse?
      @event == 'create'
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
      %Q|#{username} created #{type} "#{name}"|
    end

    def html_url
      @params[:repository][:html_url]
    end

    def url
      "#{html_url}/tree/#{name}"
    end
  end
end
