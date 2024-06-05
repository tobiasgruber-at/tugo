module ApplicationHelper
  # @return Whether a user is logged in.
  def logged_in?
    !!session[:user_email]
  end
end
