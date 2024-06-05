module ApplicationHelper

  # Return whether the user is logged in.
  #
  # @return [Boolean] Whether a user is logged in.
  def logged_in?
    !!session[:user_email]
  end
end
