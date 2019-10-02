class SubscribeForm
  include FormConcern

  attr_accessor :user_id, :group_id

  validates :user, :group, presence: true

  def perform
    return subscription.save if subscription.new_record?

    update_subscription
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def group
    @group ||= Group.find_by(id: group_id)
  end

  def subscription
    @subscription ||= Subscription.unscope(:where).find_or_initialize_by(subscription_params)
  end

  private

  def update_subscription
    return banned_subscription if subscription.banned?

    subscription.update(active: true)
  end

  def banned_subscription
    errors.add(:user, 'Usuário banido')
    false
  end

  def subscription_params
    { user_id: user_id, group_id: group_id }
  end
end
