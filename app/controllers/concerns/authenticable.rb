module Authenticable
  def current_user
    @current_user ||= User.find_by auth_token: request.headers['Authoriziation']
  end
end
