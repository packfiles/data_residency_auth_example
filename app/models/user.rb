class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: [ :github ]

  has_many :identities, dependent: :destroy

  def self.from_omniauth(auth)
    if auth.present? && auth.provider.present? && auth.uid.present?
      identity = Identity.where(provider: auth.provider, uid: auth.uid).first_or_initialize
      if auth.credentials.present?
        identity.token = auth.credentials.token
        identity.refresh_token = auth.credentials.refresh_token
      end

      if identity.user.nil? && auth.info.email.present?
        user = User.where(email: auth.info.email).first_or_initialize
        user.password = Devise.friendly_token if user.new_record?
        user.email = auth.info.email || auth.extra.raw_info.email || auth.extra.raw_info.notification_email
        user.save!
        identity.user = user
      end

      identity.save!

      if identity.user.present?
        identity.identity_profile = IdentityProfile.where(identity: identity).first_or_initialize
        identity.identity_profile.name = auth.info.name
        identity.identity_profile.avatar_url = auth.info.image
        identity.identity_profile.username = auth.extra.raw_info.login
        identity.identity_profile.uri = auth.extra.raw_info.html_url
      end

      identity.identity_profile.save!

      identity.user
    end
  end
end
