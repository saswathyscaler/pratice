class User < ApplicationRecord
    has_secure_password
  
    def invalidate_token
      self.update(token_invalidated_at: Time.current)
    end
    has_many :students
    
    validates :name, :email, :password_digest, :phone_number, presence: true
    validates :email, uniqueness: true
  end