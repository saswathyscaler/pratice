class Student < ApplicationRecord
    belongs_to :user
    validates :first_name, :last_name, :email, :contact_number, :address, :date_of_birth,  presence: true
    validates :email, uniqueness: true


end
