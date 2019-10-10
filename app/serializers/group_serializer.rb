class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :metadata

  belongs_to :institution
  belongs_to :course
  belongs_to :discipline

  def metadata
    { subscriptions: object.subscriptions.size }
  end
end
