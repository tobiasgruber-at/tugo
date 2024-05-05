require 'net/http'
require 'json'

# This provides functionality for the overarching application.
#
# @!attribute [rw] user
#   @return [User] the currently logged in user, if one is logged in, else +nil+
class ApplicationController < ActionController::Base

  layout "application"

  protected

  # Sets the user instance variable to the currently logged in user, or +nil+ if no user is logged in.
  #
  # @return [void]
  def user
    @user ||= User.find_by_email(session[:user_email]) if logged_in?
  end

  # Returns whether the current user is logged in or not.
  #
  # @return [Boolean] whether the user is logged in or not
  def logged_in?
    !!session[:user_email]
  end

  # TODO YARD doc
  # @private
  def redirect_if_not_logged_in
    unless logged_in?
      redirect_to login_path
    end
  end

  # TODO YARD doc
  # @private
  def redirect_if_logged_in
    if logged_in?
      redirect_to root_path
    end
  end
end
