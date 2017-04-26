class AddCounters < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :likes_count, :integer, null: false, default: 0
    add_column :posts, :recent_likes_count, :integer, null: false, default: 0
    add_column :posts, :comments_count, :integer, null: false, default: 0
  end
end
