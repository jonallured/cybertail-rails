FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com"
    end

    password 'password'
    bookmarked_at Time.current
  end
end
