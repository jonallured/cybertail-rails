FactoryBot.define do
  factory :raw_hook do
    body 'Something awesome'
    headers { { omg: 'lol' } }
    params { { foo: 'bar' } }
  end
end
