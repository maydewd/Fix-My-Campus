class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :nickname
      t.string :email_prefix

      t.timestamps
    end
  end
end
