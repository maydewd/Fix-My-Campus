class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :message, null: false
      
      t.references :user, index: true, foreign_key: true, optional: true
      t.references :school, index: true, foreign_key: true, null: false
      
      t.boolean :legacy, null: false, default: false
      t.string :legacy_user_name
      t.string :legacy_fbid, index: true
      t.integer :legacy_numlikes, null: false, default: 0

      t.timestamps
    end
  end
end
