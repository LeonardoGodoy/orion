class AddBannedToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :banned, :boolean, default: false
  end
end
