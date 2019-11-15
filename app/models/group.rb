class Group < ApplicationRecord
  belongs_to :institution, optional: true
  belongs_to :course, optional: true
  belongs_to :discipline, optional: true

  has_many :subscriptions, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :users, through: :subscriptions

  validates :name, presence: true

  scope :privates, -> { where(private_group: true) }

  def manager?(user)
    subscriptions.managers.exists?(user_id: user.id)
  end
end
