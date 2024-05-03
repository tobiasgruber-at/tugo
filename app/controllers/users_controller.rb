class UsersController < ApplicationController
  before_action :redirect_if_not_logged_in

  def new
    @user = User.new
  end

  def create
    begin
      @user = User.new(user_params)

      if @user.valid? && @user.save
        session[:user_id] = @user.id
        session[:user_email] = @user.email
        redirect_to root_path, notice: "Successfully signed up."
      else
        render :new, status: :unprocessable_entity
      end
    rescue StandardError => e
      @user = User.new
      flash.now[:alert] = "An error occurred. Please try again later."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
