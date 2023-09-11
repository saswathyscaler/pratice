require 'jwt'

class JsonWebToken
  SECRET_KEY = 'your_secret_key'
  ALGORITHM = 'HS256'

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY, true, algorithm: ALGORITHM)[0]
  end
end
