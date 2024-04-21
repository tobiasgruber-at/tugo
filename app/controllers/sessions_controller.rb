class SessionsController < ApplicationController
  before_action :redirect_if_not_logged_in, only: [:new, :create]

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)
    if @session.valid?
      user = User.find_by(email: session_params[:email])
      if user
        @session.errors.add(:password, "is incorrect") unless user.authenticate(session_params[:password])
      else
        @session.errors.add(:email, "not found")
      end
      return render :new, status: :unprocessable_entity if @session.errors.any?
      session[:user_email] = user.email
      # TODO: redirect to homepage
      redirect_to projects_path
    else
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
