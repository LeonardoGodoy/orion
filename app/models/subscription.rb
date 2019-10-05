class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :group

  scope :active, -> { where(active: true, banned: false) }
  scope :managers, -> { active.where(manager: true) }

  validates :group, uniqueness: { scope: :user }
end
