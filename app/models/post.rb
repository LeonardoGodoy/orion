class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many :classifications, class_name: 'PostClassification'
  has_many_attached :files

  def update_like_counter
    return if classifications.blank?

    update(like_count: classifications.like.count)
  end

  def update_unlike_counter
    return if classifications.blank?

    update(unlike_count: classifications.unlike.count)
  end
end
