class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true
  validates :oauth_token, presence: true

  def self.from_omniauth(auth)
    if auth
      where(uid: auth.uid).first_or_initialize.tap do |user|
        user.email = auth.info.email
        user.oauth_token = auth.credentials.token
        user.save!
      end
    end
  end
end
