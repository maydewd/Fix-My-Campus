class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :nickname
      t.string :email_suffix
      t.string :background_color
      t.string :text_color
      t.integer :seed_id

      t.timestamps
    end
    
    add_index :schools, :seed_id,       unique: true
    add_index :schools, :name,          unique: true
    add_index :schools, :nickname,      unique: true
    add_index :schools, :email_suffix,  unique: true
  end
end
