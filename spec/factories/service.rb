FactoryGirl.define do
  factory :service do
    name 'A Service'
  end

  factory :circle_service, class: :service do
    name 'Circle CI'
  end

  factory :github_service, class: :service do
    name 'GitHub'
  end

  factory :heroku_service, class: :service do
    name 'Heroku'
  end

  factory :honeybadger_service, class: :service do
    name 'Honeybadger'
  end

  factory :travis_service, class: :service do
    name 'Travis CI'
  end
end
