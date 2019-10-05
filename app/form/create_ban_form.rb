class CreateBanForm < ManagerForm
  def subscription_params
    { banned: true, active: false }
  end
end
