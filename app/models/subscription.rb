class Subscription < ApplicationRecord
  default_scope { active }

  belongs_to :user
  belongs_to :group

  scope :active, -> { where(active: true) }

  validates :group, uniqueness: { scope: :user }
end
