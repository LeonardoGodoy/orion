class ManagerForm
  include FormConcern

  attr_accessor :subscription_id, :user_id, :manager

  validates :subscription, :user, presence: true
  validate :validate_user

  def validate_user
    return if user.blank?
    return if subscription.blank?
    return if manager_update?

    errors.add(:user, 'Usuário não permitido')
  end

  def perform
    return false if invalid?

    subscription.update(subscription_params)
  end

  def subscription
    @subscription ||= Subscription.unscope(:where).find_by(id: subscription_id)
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def manager_update?
    subscription.group.manager?(user)
  end

  def subscription_params
    { manager: manager }
  end
end
