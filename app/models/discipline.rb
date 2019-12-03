class Discipline < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :performances, dependent: :destroy
  has_many :absences, dependent: :destroy
  has_many :subscriptions, through: :groups

  belongs_to :course
  has_many :performances
end
