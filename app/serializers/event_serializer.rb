class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :date, :hour, :created_at, :updated_at

  belongs_to :user, key: :student
  belongs_to :group

  def date
    I18n.l(object.date, format: '%Y-%m-%d')
  end

  def hour
    I18n.l(object.date, format: '%H-%M')
  end
end
