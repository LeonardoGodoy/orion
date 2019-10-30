class CreatePostClassificationForm
  include FormConcern
  include ValidateStudentForm

  attr_accessor :like, :user_id, :post_id

  validates :user, :post, presence: true
  validate :allow_only_subscribed

  def perform
    return false if invalid?

    classification.like = like
    classification.save
  end

  def classification
    @classification ||= PostClassification.find_or_initialize_by(classification_params)
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def post
    @post ||= Post.find_by(id: post_id)
  end

  def group
    @group ||= post.try(:group)
  end

  def subscription
    @subscription ||= Subscription.active.find_by(subscription_params)
  end

  private

  def subscription_params
    { group_id: group.try(:id), user_id: user_id }
  end

  def classification_params
    { user_id: user_id, post_id: post_id }
  end
end
