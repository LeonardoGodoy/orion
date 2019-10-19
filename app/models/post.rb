class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many_attached :files
end
