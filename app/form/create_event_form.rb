class CreateEventForm
  include FormConcern

  attr_accessor :title, :content, :date, :user_id, :group_id

  validates :user, :group, :subscription, presence: true

  def perform
    return false if invalid?

    event.save
  end

  def event
    @event ||= Event.new(event_params)
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def group
    @group ||= Group.find_by(id: group_id)
  end

  def subscription
    @subscription ||= Subscription.find_by(group_id: group_id, user_id: user_id)
  end

  private

  def event_params
    {
      title: title,
      content: content,
      date: date,
      user_id: user_id,
      group_id: group_id
    }
  end
end
