class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.references :institution
      t.references :course
      t.references :discipline
      t.string :name

      t.timestamps
    end
  end
end
