class ApplicationController < ActionController::API

    # skip_before_action :verify_authenticity_token 

    def authenticate_user
      token = request.headers['Authorization']&.split(' ')&.last
      if token.present? && JsonWebToken.decode(token)
        return true
      else
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    rescue JWT::DecodeError
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  
    def current_user
      token = request.headers['Authorization']&.split(' ')&.last
      decoded_token = JsonWebToken.decode(token)
      User.find(decoded_token['user_id'])
    end
  end
  