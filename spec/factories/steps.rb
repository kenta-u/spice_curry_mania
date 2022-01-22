FactoryBot.define do
  factory :step do
    direction { "test" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root,'spec/fixtures/sample_step.jpeg')) }
    recipe
  end
end
