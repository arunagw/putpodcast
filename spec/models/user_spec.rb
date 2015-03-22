require "rails_helper"

describe User, type: :model do
  it { should validate_presence_of :oauth_token }
  it { should validate_presence_of :uid }

  describe ".from_omniauth" do
    context "when auth is given" do
      it "does not create a user" do
        User.from_omniauth(nil)

        expect(User.count).to eq(0)
      end
    end

    context "when auth is present" do
      context "when user already exists" do
        it "update existing user" do
          email = "foo@example.com"
          oauth_token = "some-token"
          uid = "long-uid"
          user = create(:user, uid: uid)
          info = double("Info", email: email)
          credentials = double("credentials", token: oauth_token)
          auth = double(
            "Auth",
            info: info,
            credentials: credentials,
            uid: uid
          )

          User.from_omniauth(auth)

          user.reload
          expect(user.uid).to eq(user.uid)
          expect(user.oauth_token).to eq(oauth_token)
          expect(user.email).to eq(email)
          expect(User.count).to eq(1)
        end
      end

      context "when user is not exists" do
        it "creates a new user with auth data" do
          email = "foo@example.com"
          oauth_token = "some-token"
          uid = "long-uid"
          info = double("Info", email: email)
          credentials = double("credentials", token: oauth_token)
          auth = double(
            "Auth",
            info: info,
            credentials: credentials,
            uid: uid
          )

          User.from_omniauth(auth)

          user = User.last
          expect(user.uid).to eq(user.uid)
          expect(user.oauth_token).to eq(oauth_token)
          expect(user.email).to eq(email)
          expect(User.count).to eq(1)
        end
      end
    end
  end
end
