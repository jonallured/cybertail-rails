desc 'Populate the services table'
task populate_services: :environment do
  names = ['Travis CI', 'Heroku', 'GitHub']

  for name in names
    Service.create(name: name) unless Service.find_by(name: name)
  end
end