class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :date, :created_at, :updated_at

  belongs_to :user, key: :student
  belongs_to :group
end
