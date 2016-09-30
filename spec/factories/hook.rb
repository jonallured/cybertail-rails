FactoryGirl.define do
  factory :hook do
    payload '{ "key": "value"}'
    project 'user/project'
    message 'This hook happened.'
    url 'http://example.com'
    sent_at Time.now
  end
end
