class Performance < ApplicationRecord
  belongs_to :user
  belongs_to :discipline

  validates :value, :max_value, presence: true

  def percentage
    ((100.0 / max_value) * value).round(2)
  end
end
