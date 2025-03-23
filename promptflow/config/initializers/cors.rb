Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Allows requests from any origin

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end