class AddPrivateGroupToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :private_group, :boolean, default: false
  end
end
