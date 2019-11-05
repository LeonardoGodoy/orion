class Institution < ApplicationRecord
  has_many :groups
  has_many :courses
  has_many :subscriptions, through: :groups
end
