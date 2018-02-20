FactoryBot.define do
  factory :service do
    name 'A Service'
  end

  factory :circle_service, class: :service do
    name 'Circle CI'
    parser 'CircleParser'
  end

  factory :github_service, class: :service do
    name 'GitHub'
    parser 'GithubService'
  end

  factory :heroku_service, class: :service do
    name 'Heroku'
    parser 'HerokuParser'
  end

  factory :honeybadger_service, class: :service do
    name 'Honeybadger'
    parser 'HoneybadgerParser'
  end

  factory :travis_service, class: :service do
    name 'Travis CI'
    parser 'TravisParser'
  end
end
