class CreatePostClassifications < ActiveRecord::Migration[5.2]
  def change
    create_table :post_classifications do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :like, default: false

      t.timestamps
    end
  end
end
