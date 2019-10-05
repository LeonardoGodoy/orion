class UnsubscribeForm
  include FormConcern
  include ValidateStudentForm

  attr_accessor :user_id, :subscription_id

  validates :user, presence: true
  validate :allow_self_and_manager

  def perform
    return false if invalid?

    subscription.update(subscription_params)
  end

  def subscription
    @subscription ||= Subscription.find_by(id: subscription_id)
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def subscription_params
    { active: false }
  end
end
