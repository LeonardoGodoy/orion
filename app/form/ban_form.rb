class BanForm < ManagerForm
  attr_accessor :banned

  def subscription_params
    { banned: banned, active: !banned }
  end
end
