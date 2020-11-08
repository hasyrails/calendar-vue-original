class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_current_user, only: %i[index]


  def index
    @users = User.all
  end

  def new_guest
    @user = User.guest
    sign_in @user
    @user.update(name: 'ゲスト')
    render json: @user
  end

  def guest_logout
  end
end
