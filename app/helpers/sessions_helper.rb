module SessionsHelper

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def sign_in(user)
    user.reset_token
    session[:session_token] = user.session_token

    @current_user = user
  end

  def sign_out
    current_user.reset_token
    @current_user = nil
    session[:session_token] = nil
  end

  def require_current_user!
    # redirect_to new_session_url if current_user.nil?
  end

  def require_no_current_user!
    # redirect_to user_url(current_user) unless current_user.nil?
  end
  #
  # def is_authorized?(user)
  #
  # end
end
