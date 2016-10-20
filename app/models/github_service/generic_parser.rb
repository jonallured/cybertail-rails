module GithubService
  class GenericParser < BaseParser
    def parse
      hook = super
      hook.update_attributes message: "Got event #{@event}, saved as Hook #{hook.id}."
      hook
    end

    def able_to_parse?
      true
    end

    private

    def message
      'tmp'
    end

    def url
      'https://github.com'
    end
  end
end
