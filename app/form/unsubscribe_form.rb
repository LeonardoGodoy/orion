class UnsubscribeForm
  include FormConcern

  attr_accessor :user_id, :subscription_id

  validates :subscription, :user, presence: true
  validate :validate_user

  def validate_user
    return if user.blank?
    return if subscription.blank?
    return if self_update?
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

  def self_update?
    subscription.user.eql?(user)
  end

  def subscription_params
    { active: false }
  end
end
