class CreateManagerForm < ManagerForm
  def subscription_params
    { manager: true }
  end
end
