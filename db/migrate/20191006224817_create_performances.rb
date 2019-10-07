class CreatePerformances < ActiveRecord::Migration[5.2]
  def change
    create_table :performances do |t|
      t.references :user, foreign_key: true
      t.references :discipline, foreign_key: true
      t.string :description
      t.decimal :value, default: 0
      t.decimal :max_value, default: 100

      t.timestamps
    end
  end
end
