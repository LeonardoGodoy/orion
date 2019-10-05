class ManagerForm
  include FormConcern
  include ValidateStudentForm

  attr_accessor :subscription_id, :user_id

  validates :user, presence: true
  validate :allow_only_manager

  def perform
    return false if invalid?

    subscription.update(subscription_params)
  end

  def subscription
    @subscription ||= Subscription.active.find_by(id: subscription_id)
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def subscription_params; end
end
