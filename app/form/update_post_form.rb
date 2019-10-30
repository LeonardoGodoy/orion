class UpdatePostForm
  include FormConcern

  attr_accessor :title, :content, :files, :files_to_remove, :user_id, :post_id

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

    purge_files
    post.update(post_params)
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def post
    @post ||= Post.find_by(id: post_id)
  end

  def purge_files
    return if files_to_remove.blank?

    files_to_remove.each do |_index, blob_id|
      blob = post.files.find_by(blob_id: blob_id)
      blob.purge if blob.present?
    end
  end

  private

  def post_params
    {
      title: title,
      content: content,
      files: files || []
    }
  end
end
