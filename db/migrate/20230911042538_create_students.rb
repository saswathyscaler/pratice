class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :contact_number  
      t.string :address         
      t.date :date_of_birth     

      t.timestamps
    end
  end
end
