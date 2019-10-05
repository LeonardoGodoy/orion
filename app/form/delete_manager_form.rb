class DeleteManagerForm < ManagerForm
  def subscription_params
    { manager: false }
  end

  def subscription
    @subscription ||= Subscription.find_by(id: subscription_id)
  end
end
