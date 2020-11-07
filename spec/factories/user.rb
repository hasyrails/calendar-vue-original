include Rack::Test::Methods

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "testuser#{n}" }
    sequence(:email) { |n| "testuser#{n}@example.com" }
    # image { File.open("#{Rails.root}/spec/fixtures/testicon.png") }
    password { "password" }
    password_confirmation { "password" }
  end
end
