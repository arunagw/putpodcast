Rails.application.config.middleware.use OmniAuth::Builder do
  provider :putio, ENV['PUTIO_CLIENT_ID'], ENV['PUTIO_CLIENT_SECRET']
end
