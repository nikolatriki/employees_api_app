class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.string :country
      t.text :bio
      t.date :date_of_birth
      t.float :rating

      t.timestamps
    end
  end
end
