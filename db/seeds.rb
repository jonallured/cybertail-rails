services = [
  { id: 1, name: 'Travis CI', parser: 'TravisParser' },
  { id: 2, name: 'Heroku', parser: 'HerokuParser' },
  { id: 3, name: 'GitHub', parser: 'GithubService' },
  { id: 4, name: 'Honeybadger', parser: 'HoneybadgerParser' },
  { id: 5, name: 'Circle CI', parser: 'CircleParser' }
]

services.each do |attrs|
  Service.create(attrs) unless Service.exists?(attrs)
end
