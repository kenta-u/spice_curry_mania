FactoryBot.define do
  factory :recipe do
    name { "test_recipe" }
    survings { 1 }
    category { 0 }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root,'spec/fixtures/test.jpeg')) }
    user

    factory :recipe_with_all do
      after( :create ) do |recipe|
        create(:ingredient, recipe: recipe)
      end

      after( :create ) do |recipe|
        create(:spice, recipe: recipe)
      end

      after( :create ) do |recipe|
        create(:step, recipe: recipe)
      end
    end
  end
end
