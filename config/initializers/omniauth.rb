Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['TOOBROK_FACEBOOK_KEY'], ENV['TOOBROK_FACEBOOK_SECRET']
  provider :twitter, ENV['TOOBROK_TWITTER_KEY'], ENV['TOOBROK_TWITTER_SECRET']
  provider :google_oauth2, ENV["TOOBROK_GOOGLE_CLIENT_ID"], ENV["TOOBROK_GOOGLE_CLIENT_SECRET"]
end