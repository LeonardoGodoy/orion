class DeleteBanForm < ManagerForm
  def subscription_params
    { banned: false, active: true }
  end

  def subscription
    @subscription ||= Subscription.find_by(id: subscription_id)
  end
end
