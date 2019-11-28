class AddYearToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :year, :integer
  end
end
