class Event < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :title, presence: true
end
