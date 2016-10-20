module GithubService
  PARSERS = [
    TravisStatusParser,
    DeleteParser,
    CreateParser,
    PushParser,
    GenericParser
  ]

  def self.parse(event, params)
    parsers = PARSERS.map { |klass| klass.new(event, params) }
    parser = parsers.find &:able_to_parse?
    parser.parse
  end
end
