class AddUserIdToStudents < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :user, index: true, foreign_key: true, null: true
  end
  
end
