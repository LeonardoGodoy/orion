class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable,
         :recoverable, :rememberable, :validatable

  has_many :subscriptions, dependent: :destroy
  has_many :groups, through: :subscriptions
  has_many :performances, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :classifications, class_name: 'PostClassification', dependent: :destroy
end
