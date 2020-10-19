class Api::SessionsController < ApplicationController
  def whoami
    render json: current_api_user, status: :ok
  end
end

