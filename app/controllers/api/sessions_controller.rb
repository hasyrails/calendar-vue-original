class Api::SessionsController < ApplicationController
 

  def whoami
    if current_user.nil?
      response_unauthorized
    else
      render json: current_user
    end
  end
end

