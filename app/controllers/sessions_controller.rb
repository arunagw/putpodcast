class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(auth)

    redirect_to root_url
  end

  private

  def auth
    request.env["omniauth.auth"]
  end
end
