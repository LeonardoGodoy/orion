class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :year, :created_at, :updated_at, :metadata
  attribute :colleagues, if: :include_colleagues?
  attribute :private_group, key: :private

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
