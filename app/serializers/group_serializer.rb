class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :metadata
  attribute :colleagues, if: :include_colleagues?

  belongs_to :institution
  belongs_to :course
  belongs_to :discipline

  def metadata
    { subscriptions: object.subscriptions.size }
  end

  def colleagues
    @instance_options[:colleagues]
  end

  def include_colleagues?
    @instance_options[:colleagues].present?
  end
end
