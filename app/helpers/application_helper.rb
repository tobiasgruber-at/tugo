module ApplicationHelper
  def logged_in?
    !!session[:user_email]
  end
end
