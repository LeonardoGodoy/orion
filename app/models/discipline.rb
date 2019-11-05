class Discipline < ApplicationRecord
  has_many :groups
  has_many :subscriptions, through: :groups

  belongs_to :course
  has_many :performances
end
