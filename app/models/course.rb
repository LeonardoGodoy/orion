class Course < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :disciplines, dependent: :destroy
  has_many :subscriptions, through: :groups

  belongs_to :institution
end
