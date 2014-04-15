class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    sign_in @user
    redirect_to new_website_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end