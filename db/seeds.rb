services = [
  { id: 1, name: 'Travis CI' },
  { id: 2, name: 'Heroku' },
  { id: 3, name: 'GitHub' },
  { id: 4, name: 'Honeybadger' }
]

for attrs in services
  Service.create(attrs) unless Service.exists?(attrs)
end
