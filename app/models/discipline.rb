class Discipline < ApplicationRecord
  has_many :groups
  has_many :subscriptions, through: :groups
end
