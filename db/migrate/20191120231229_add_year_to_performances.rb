class AddYearToPerformances < ActiveRecord::Migration[5.2]
  def change
    add_column :performances, :year, :integer
  end
end
