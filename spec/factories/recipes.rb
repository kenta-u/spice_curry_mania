FactoryBot.define do
  factory :recipe do
    name { "MyString" }
    survings { 1 }
    category { 1 }
    image { "MyString" }
    user { nil }
  end
end
