Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['TOOBROK_FACEBOOK_KEY'], ENV['TOOBROK_FACEBOOK_SECRET']
  provider :twitter, ENV['TOOBROK_TWITTER_KEY'], ENV['TOOBROK_TWITTER_SECRET']
  provider :google_oauth2, ENV["TOOBROK_GOOGLE_CLIENT_ID"], ENV["TOOBROK_GOOGLE_CLIENT_SECRET"]
  provider :github, ENV['TOOBROK_GITHUB_KEY'], ENV['TOOBROK_GITHUB_SECRET'], scope: "user,repo,gist"
  provider :linkedin, ENV['TOOBROK_LINKEDIN_KEY'], ENV['TOOBROK_LINKEDIN_SECRET']
end
