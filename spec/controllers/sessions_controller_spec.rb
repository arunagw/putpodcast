require 'rails_helper'

describe SessionsController, type: :controller do
  context "#create" do
    it "calls user from omniauth" do
      allow(User).to receive(:from_omniauth)
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:putio]
      request.env["omniauth.origin"] = nil

      get :create, provider: "putio"

      should redirect_to(root_url)
      expect(User).to have_received(:from_omniauth)
    end
  end
end
