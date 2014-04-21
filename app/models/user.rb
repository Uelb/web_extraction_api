class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :extractions
  has_many :websites, through: :extractions

  def self.find_or_create_from_auth_hash auth_hash
    send((auth_hash['provider'] + "_auth").to_sym, auth_hash)
  end

  protected
  def self.facebook_auth auth_hash
    @user = find_provider_user auth_hash
    return @user if @user
    generated_password = Devise.friendly_token.first(8)
    @user = User.create(
      email:                  auth_hash['info']['email'],
      nickname:               auth_hash["info"]["nickname"],
      password:               generated_password,
      password_confirmation:  generated_password,
      provider:               auth_hash['provider'],
      uid:                    auth_hash['uid'],
      provider_token:         auth_hash['credentials']['token']
    )
  end

  def self.twitter_auth auth_hash
    @user = find_provider_user auth_hash
    return @user if @user
    generated_password = Devise.friendly_token.first(8)
    @user = User.create(
      email:                  auth_hash["info"]["nickname"] + "@twitter.com",
      nickname:               auth_hash["info"]["nickname"],
      password:               generated_password,
      password_confirmation:  generated_password,
      provider:               auth_hash['provider'],
      uid:                    auth_hash['uid'],
      provider_token:         auth_hash['credentials']['token']
    )
  end

  def self.google_oauth2_auth auth_hash
    @user = find_provider_user auth_hash
    return @user if @user
    generated_password = Devise.friendly_token.first(8)
    @user = User.create(
      email:                  auth_hash['info']['email'],
      nickname:               auth_hash["info"]["name"],
      password:               generated_password,
      password_confirmation:  generated_password,
      provider:               auth_hash['provider'],
      uid:                    auth_hash['uid'],
      provider_token:         auth_hash['credentials']['token']
    )
  end

  def self.github_auth auth_hash
    @user = find_provider_user auth_hash
    return @user if @user
    generated_password = Devise.friendly_token.first 8
    @user = User.create(
      email:                  auth_hash["info"]["email"],
      password:               generated_password,
      password_confirmation:  generated_password,
      provider:               auth_hash['provider'],
      uid:                    auth_hash["uid"]
    )
  end

  def self.linkedin_auth auth_hash
    @user = find_provider_user auth_hash
    return @user if @user
    generated_password = Devise.friendly_token.first 8
    @user = User.create(
      email:                  auth_hash["info"]["email"],
      nickname:               auth_hash["info"]["first_name"] + auth_hash["info"]["last_name"],
      password:               generated_password,
      password_confirmation:  generated_password,
      provider:               auth_hash['provider'],
      uid:                    auth_hash["uid"]
    )
  end

  def self.find_provider_user auth_hash
    where(provider: auth_hash[:provider], uid: auth_hash[:uid]).first
  end

end