class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :message, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.references :post, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
