# This is a controller for sessions.
#
# @!attribute [r] session
#   @return [Session] the current session
class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  # Renders a form to log in.
  #
  # After a call to this method, the {#session} instance variable will be set.
  #
  # @return [void]
  def new
    @session = Session.new
  end

  # Creates a new session.
  #
  # After a call to this method, the {#session} instance variable will be set.
  #
  # @return [void]
  def create
    begin
      @session = Session.new(session_params)
      if @session.valid?
        user = User.find_by(email: session_params[:email])
        if user
          @session.errors.add(:password, "is incorrect") unless user.authenticate(session_params[:password])
        else
          @session.errors.add(:email, "not found")
        end
        return render :new, status: :unprocessable_entity if @session.errors.any?
        session[:user_id] = user.id
        session[:user_email] = user.email
        redirect_to root_path, notice: "Logged in."
      else
        render :new, status: :unprocessable_entity
      end
    rescue StandardError => e
      puts e.message
      @session = Session.new
      flash.now[:alert] = "An error occurred. Please try again later."
      render :new, status: :unprocessable_entity
    end
  end

  # Destroys the current session.
  #
  # @return [void]
  def destroy
    reset_session
    redirect_to login_path, notice: "Logged out."
  end

  private

  # The validated parameter for a new session
  def session_params
    params.require(:session).permit(:email, :password)
  end

end
