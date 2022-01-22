FactoryBot.define do
  factory :recipe do
    name { "test_recipe" }
    survings { 1 }
    category { 0 }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root,'spec/fixtures/test.jpeg')) }
    user
  end
end
