module GithubService
  PARSERS = [
    TravisStatusParser,
    DeleteParser,
    CreateParser,
    WatchParser,
    IssueParser,
    CommentParser,
    PingParser,
    PushParser,
    GenericParser
  ]

  def self.parse(event, params, project)
    parsers = PARSERS.map { |klass| klass.new(event, params, project) }
    parser = parsers.find &:able_to_parse?
    parser.parse
  end
end
