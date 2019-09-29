class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at
  attribute :metadata, if: :include_metadata

  def metadata
    { subscriptions: object.subscriptions.size }
  end

  def include_metadata
    !!@instance_options[:metadata]
  end
end
