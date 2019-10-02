class AddManagerToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :manager, :boolean, default: false
  end
end
