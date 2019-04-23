# create_table :employees do |t|
#   t.integer  "school_id"
#   t.integer  "role_id"
# end

class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.references :school, foreign_key: true
      t.references :role, foreign_key: true
      t.string :name
      t.integer :uid
      t.integer :password
      t.timestamps
    end
    add_index :employees, :uid, unique: true
  end
end
