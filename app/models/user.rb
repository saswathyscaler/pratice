class User < ApplicationRecord
    has_secure_password
  
    def invalidate_token
      self.update(token_invalidated_at: Time.current)
    end
    has_many :students

  end