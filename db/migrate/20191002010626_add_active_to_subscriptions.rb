class AddActiveToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :active, :boolean, default: true
  end
end
