class UpdatePostForm
  include FormConcern

  attr_accessor :title, :content, :files, :user_id, :post_id

  validates :user, :post, presence: true

  validate :allow_only_self

  def allow_only_self
    return if user.blank?
    return if post.blank?
    return if post.user.eql?(user)

    errors.add(:user, 'not allowed')
  end

  def perform
    return false if invalid?

    post.update(post_params)
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def post
    @post ||= Post.find_by(id: post_id)
  end

  private

  def post_params
    {
      title: title,
      content: content,
      files: files
    }
  end
end
