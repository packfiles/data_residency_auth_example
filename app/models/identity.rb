class Identity < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_one :identity_profile, dependent: :destroy
end
