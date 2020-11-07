FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test_#{n}" }
    sequence(:email) { |n| "test+#{n}@example.com" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/testicon.png'), 'image/png') }
    password { "password" }
    password_confirmation { "password" }
  end
end
