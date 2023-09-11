class UsersController < ApplicationController
    # skip_before_action :verify_authenticity_token 

    def create
        @user = User.new(user_params)
        if @user.save
          render json: { message: 'User created successfully' }, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def login
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
          token = JWT.encode({ user_id: @user.id }, 'your_secret_key', 'HS256')
          render json: { token: token }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end


      def logout
          decoded_token = JsonWebToken.decode(request.headers['Authorization'].split(' ').last)
          user_id = decoded_token['user_id']
        
          if User.find(user_id).invalidate_token
            render json: { message: 'Logged out successfully' }, status: :ok
          else
            render json: { error: 'Logout failed' }, status: :unprocessable_entity
          end
        end

        # def current_user
        #     token = request.headers['Authorization']&.split(' ')&.last
        #     decoded_token = JsonWebToken.decode(token)
        #     User.find(decoded_token['user_id'])
        #   end

      private
      
      def user_params
        params.require(:user).permit(:name, :email, :password, :phone_number)
      end
      
end
