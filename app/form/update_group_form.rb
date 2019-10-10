class UpdateGroupForm
  include FormConcern
  include ValidateStudentForm

  attr_accessor :name, :description, :user_id, :group_id

  validates :user, :group, presence: true

  validate :allow_only_subscribed

  def perform
    return false if invalid?

    group.update(group_params)
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def group
    @group ||= Group.find_by(id: group_id)
  end

  def subscription
    @subscription ||= Subscription.active.find_by(subscription_params)
  end

  private

  def subscription_params
    { group_id: group_id, user_id: user_id }
  end

  def group_params
    {
      name: name.try(:strip),
      description: description.try(:strip)
    }
  end
end
