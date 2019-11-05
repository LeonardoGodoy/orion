class Course < ApplicationRecord
  has_many :groups
  has_many :disciplines
  has_many :subscriptions, through: :groups

  belongs_to :institution
end
