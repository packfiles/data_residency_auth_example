class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: [:github, :github_data_residency]
  
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
        user.name = auth.info.name
        user.password = Devise.friendly_token if user.new_record?
        user.save!
        identity.user = user
      end
      identity.save!
      identity.user
    end
  end
end
