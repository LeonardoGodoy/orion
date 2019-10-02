class UnsubscribeForm
  include FormConcern

  attr_accessor :user_id, :subscription_id

  validates :subscription, :user, presence: true
  validate :validate_user

  def validate_user
    return if subscription.blank?
    return if subscription.user.eql?(user) || subscription.group.manager?(user)

    errors.add(:user, 'Usuário não permitido')
  end

  def perform
    return false if invalid?

    subscription.update(active: false)
  end

  def subscription
    @subscription ||= Subscription.unscope(:where).find_by(id: subscription_id)
  end

  def user
    @user ||= User.find_by(id: user_id)
  end
end
