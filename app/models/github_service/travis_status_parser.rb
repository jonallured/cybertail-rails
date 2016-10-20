module GithubService
  class TravisStatusParser < BaseParser
    def able_to_parse?
      contexts.include? @params[:context]
    end

    private

    def contexts
      [
        'continuous-integration/travis-ci/pr',
        'continuous-integration/travis-ci/push'
      ]
    end

    def message; end

    def url; end

    def suppress
      true
    end
  end
end
