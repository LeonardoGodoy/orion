class AbsenceSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :date, :year,
             :created_at, :updated_at

  belongs_to :discipline
end
