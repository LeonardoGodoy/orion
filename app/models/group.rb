class Group < ApplicationRecord
  belongs_to :institution, optional: true
  belongs_to :course, optional: true
  belongs_to :discipline, optional: true

  has_many :subscriptions
  has_many :events
  has_many :posts
  has_many :users, through: :subscriptions

  validates :name, presence: true

  scope :privates, -> { where(private_group: true) }

  def manager?(user)
    subscriptions.managers.exists?(user_id: user.id)
  end
end
