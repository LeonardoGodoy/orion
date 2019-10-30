class PostClassification < ApplicationRecord
  belongs_to :post
  belongs_to :user

  scope :like, -> { where(like: true) }
  scope :unlike, -> { where(like: false) }

  after_save :update_post_counters
  after_destroy :update_post_counters

  validates :post, uniqueness: { scope: :user }

  def update_post_counters
    post.update_like_counter
    post.update_unlike_counter
  end
end
