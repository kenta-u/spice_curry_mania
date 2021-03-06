FactoryBot.define do
  factory :user do
    name { "test" }
    sequence(:email) { |n| "test-#{n}@example.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
  end
end
