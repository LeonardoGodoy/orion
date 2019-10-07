class PerformanceSerializer < ActiveModel::Serializer
  attributes :id, :description, :value, :max_value, :percentage,
             :created_at, :updated_at

  belongs_to :discipline
end
