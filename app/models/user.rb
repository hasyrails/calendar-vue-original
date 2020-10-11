# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        #  authentication_keys: [:login]
  include DeviseTokenAuth::Concerns::User

  def token_validation_response
    as_json(only: [:id, :email, :uid, :allow_password_change, :name, :nickname, :image])
  end
end
