require 'net/http'
require 'json'

class ApplicationController < ActionController::Base
  layout "application"

  protected

  def user
    @user ||= User.find_by_email(session[:user_email]) if logged_in?
  end

  def logged_in?
    !!session[:user_email]
  end

  def redirect_if_logged_in
    unless logged_in?
      redirect_to login_path
    end
  end

  def redirect_if_not_logged_in
    if logged_in?
      # TODO: redirect to homepage
      redirect_to projects_path
    end
  end
end
