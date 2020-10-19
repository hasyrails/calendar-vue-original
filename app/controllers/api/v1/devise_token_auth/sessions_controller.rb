module Api
  module V1
    module DeviseTokenAuth
      class SessionsController < ::DeviseTokenAuth::SessionsController
        # Prevent session parameter from being passed
        # Unpermitted parameter: session
        wrap_parameters format: []

        # def whoami
        #   render json: current_api_user, status: :ok
        # end

        private

        def sign_in_params
          params.permit(:email, :password, :password_confirmation)
        end
      
      end
    end
  end
end
