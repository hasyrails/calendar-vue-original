FactoryBot.define do
  factory :user do
    name { "testuser" }
    email { "test@example.com" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/testicon.png'), 'image/png') }
    password { "password" }
    password_confirmation { "password" }
  end
end
