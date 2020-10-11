module Api
  module V1
    module DeviseTokenAuth
      class SessionsController < ::DeviseTokenAuth::SessionsController
        # Prevent session parameter from being passed
        # Unpermitted parameter: session
        wrap_parameters format: []

        private

        def sign_in_params
          params.permit(:email, :password, :password_confirmation)
        end
      
      end
    end
  end
end
