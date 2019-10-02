class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :active, :created_at, :updated_at

  belongs_to :user, key: :student
  belongs_to :group
end
