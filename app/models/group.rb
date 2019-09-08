class Group < ApplicationRecord
  belongs_to :institution, optional: true
  belongs_to :course, optional: true
  belongs_to :discipline, optional: true

  has_many :subscriptions
  has_many :users, through: :subscriptions
end
