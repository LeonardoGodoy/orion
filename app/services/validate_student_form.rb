module ValidateStudentForm
  def allow_only_manager
    return if allow_only_subscribed
    return if user.blank?
    return if current_manager?

    render_not_allowed
  end

  def allow_any_member
    return if allow_only_subscribed
    return if user.blank?
    return if current_member?

    render_not_allowed
  end

  def allow_only_self
    return if allow_only_subscribed
    return if user.blank?
    return if self_update?

    render_not_allowed
  end

  def allow_self_and_manager
    return if allow_only_subscribed
    return if user.blank?
    return if current_manager?
    return if self_update?

    render_not_allowed
  end

  def allow_only_subscribed
    return if subscription.present?

    render_not_subscribed
  end

  def render_not_allowed
    errors.add(:user, 'not allowed')
  end

  def render_not_subscribed
    errors.add(:user, 'not subscribed')
  end

  def current_member?
    subscription.group.manager?(user)
  end

  def current_manager?
    subscription.group.manager?(user)
  end

  def self_update?
    subscription.user.eql?(user)
  end
end
