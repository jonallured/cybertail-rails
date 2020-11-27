FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com"
    end

    password { 'sh' * 9 }
    bookmarked_at Time.current

    factory :admin do
      id 1
      email 'admin@example.com'
    end
  end
end
