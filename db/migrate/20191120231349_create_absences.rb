class CreateAbsences < ActiveRecord::Migration[5.2]
  def change
    create_table :absences do |t|
      t.date :date
      t.integer :year
      t.integer :quantity, default: 1
      t.references :discipline, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
