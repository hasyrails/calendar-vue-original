module Api
  module V1
    module Auth
      class RegistrationsController < ::DeviseTokenAuth::RegistrationsController

        wrap_parameters format: []

        private
        def sign_up_params
          params.permit(:name, :email, :image, :password, :password_confirmation)
        end

        def account_update_params
          params.permit(:name, :email, :image)
        end

      end
    end
  end
end
