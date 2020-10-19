Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:5000'

    resource '*',
      headers: :any,
      expose: ['access-token', 'uid', 'client'], #この行を新たに追加
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
