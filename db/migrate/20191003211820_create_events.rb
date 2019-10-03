class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      t.string :title
      t.string :content
      t.datetime :date

      t.timestamps
    end
  end
end
