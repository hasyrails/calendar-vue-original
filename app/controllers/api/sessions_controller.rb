class Api::SessionsController < ApplicationController
  def whoami
    if current_api_user.nil?
      response_unauthorized
    else
      render json: current_api_user
    end
  end
end

