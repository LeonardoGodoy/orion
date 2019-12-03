class Institution < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :subscriptions, through: :groups
end
