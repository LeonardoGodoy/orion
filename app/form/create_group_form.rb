class CreateGroupForm
  include FormConcern

  attr_accessor :institution_id, :course_id, :discipline_id,
                :name, :private, :user

  def perform
    if valid?
      save
    else
      capture_errors(group)
      capture_errors(subscription)
      false
    end
  end

  def save
    ActiveRecord::Base.transaction do
      group.save
      subscription.save
      true
    end
  end

  def subscription
    @subscription ||= group.subscriptions.new(subscription_params)
  end

  def group
    @group ||= Group.new(group_params)
  end

  def subscription_params
    { manager: true, user_id: user.id, group_id: group.id }
  end

  def group_params
    {
      institution_id: institution_id,
      course_id:      course_id,
      discipline_id:  discipline_id,
      #private:       private,
      name:           name.try(:strip)
    }
  end
end