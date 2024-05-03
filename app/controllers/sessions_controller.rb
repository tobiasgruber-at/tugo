class SessionsController < ApplicationController
  before_action :redirect_if_not_logged_in, only: [:new, :create]

  def new
    @session = Session.new
  end

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
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    rescue StandardError => e
      @session = Session.new
      flash.now[:alert] = "An error occurred. Please try again later."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
