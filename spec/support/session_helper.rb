#/spec/support/helpers/session_helper.rb 
module SessionHelper 

  def set_request_headers(resp) 
  { 'ACCEPT' => "application/json", 
   'Content-Type' => "application/json", 
   'access-token' => resp['access-token'], 
   'token-type' => resp['token-type'], 
   'client' => resp['client'], 
   'expiry' => resp['expiry'], 
   'uid' => resp['uid'] 
  } 
  end 

  def subdomain_login(uid, password, subdomain) 
  request_params = { 
   'email' => uid, 
   'password' => password 
  } 
  host! "#{subdomain}.lvh.me" 
  post "localhost:5000/api/v1/auth/sign_in", params: request_params 
  return set_request_headers(response.headers) 
  end 
end 
