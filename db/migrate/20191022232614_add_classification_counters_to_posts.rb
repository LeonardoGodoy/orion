class AddClassificationCountersToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :like_count, :integer, default: 0
    add_column :posts, :unlike_count, :integer, default: 0
  end
end
