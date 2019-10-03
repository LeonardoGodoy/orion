class DeleteEventForm
  include FormConcern

  attr_accessor :title, :content, :date, :user_id, :event_id

  validates :user, :event, :subscription, presence: true

  validate :validates_user

  def validates_user
    return if user.blank?
    return if subscription.blank?
    return if self_update?

    errors.add(:user, 'Usuário não permitido')
  end

  def perform
    return false if invalid?

    event.destroy
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def event
    @event ||= Event.find_by(id: event_id)
  end

  def subscription
    @subscription ||= Subscription.find_by(group_id: event.try(:group_id), user_id: user_id)
  end

  def self_update?
    subscription.user.eql?(user)
  end
end
