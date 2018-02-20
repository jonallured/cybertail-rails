FactoryBot.define do
  factory :hook do
    payload '{ "key": "value"}'
    message 'This hook happened.'
    url 'http://example.com'
    sent_at Time.current

    project
  end
end
