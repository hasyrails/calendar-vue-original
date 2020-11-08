class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, if: :devise_controller?
  
  # def current_user
  #   auth_headers = JSON.parse(cookies[:auth_headers])

  #   expiration_datetime = DateTime.strptime(auth_headers["expiry"], "%s")
  #   current_user = User.find_by(uid: auth_headers["uid"])
  # end  

  def authenticate_current_user 
    response_unauthorized if get_current_user.nil? 
  end 
    
  def get_current_user 
    # return nil unless cookies[:auth_headers] 
    # auth_headers = JSON.parse cookies[:auth_headers] 
    
    expiration_datetime = DateTime.strptime(auth_headers["expiry"], "%s") 
    current_user = User.find_by(uid: auth_headers["uid"]) 
    
    if current_user && 
        current_user.tokens.has_key?(auth_headers["client"]) && 
        expiration_datetime > DateTime.now 
    
        @current_user = current_user 
    end 
    @current_user 
  end 

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  # end
  # 200 Success
def response_success(class_name, action_name)
  render status: 200, json: { status: 200, message: "Success #{class_name.capitalize} #{action_name.capitalize}" }
end

# 400 Bad Request
def response_bad_request
  render status: 400, json: { status: 400, message: 'Bad Request' }
end

# 401 Unauthorized
def response_unauthorized
  render status: 401, json: { status: 401, message: 'Unauthorized' }
end

# 404 Not Found
def response_not_found(class_name = 'page')
  render status: 404, json: { status: 404, message: "#{class_name.capitalize} Not Found" }
end

# 409 Conflict
def response_conflict(class_name)
  render status: 409, json: { status: 409, message: "#{class_name.capitalize} Conflict" }
end

# 500 Internal Server Error
def response_internal_server_error
  render status: 500, json: { status: 500, message: 'Internal Server Error' }
end
end
