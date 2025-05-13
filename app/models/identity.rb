class Identity < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_one :identity_profile, dependent: :destroy

  def self.find_with_omniauth(auth)
    find_by(uid: auth["uid"], provider: auth["provider"])
  end

  def self.create_with_omniauth(auth)
    create(uid: auth["uid"], provider: auth["provider"])
  end
end
