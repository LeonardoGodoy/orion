class UpdateEventForm
  include FormConcern

  attr_accessor :title, :content, :date, :user_id, :event_id

  validates :user, :event, presence: true

  validate :allow_only_self

  def allow_only_self
    return if user.blank?
    return if event.blank?
    return if event.user.eql?(user)

    errors.add(:user, 'not allowed')
  end

  def perform
    return false if invalid?

    event.update(event_params)
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def event
    @event ||= Event.find_by(id: event_id)
  end

  private

  def event_params
    {
      title: title,
      content: content,
      date: date
    }
  end
end
