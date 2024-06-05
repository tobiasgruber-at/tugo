# This is the controller for users.
# @!attribute [rw] user
#   @return [User]
class UsersController < ApplicationController
  before_action :redirect_if_logged_in

  # Renders a form to create a new user.
  #
  # After a call to this method, the {#user} instance variable will be set.
  #
  # @return [void]
  def new
    @user = User.new
  end

  # Creates a new user.
  #
  # After a call to this method, the {#user} instance variable will be set.
  #
  # @return [void]
  def create
    begin
      @user = User.new(user_params)

      if @user.valid? && @user.save
        session[:user_id] = @user.id
        session[:user_email] = @user.email
        redirect_to root_path, notice: "Signed up."
      else
        render :new, status: :unprocessable_entity
      end
    rescue StandardError => e
      puts e.message
      @user = User.new
      flash.now[:alert] = "An error occurred. Please try again later."
      render :new, status: :unprocessable_entity
    end
  end

  private

  # The validated parameters for a user
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
