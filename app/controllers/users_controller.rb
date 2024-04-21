class UsersController < ApplicationController
  before_action :redirect_if_not_logged_in

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.valid? && @user.save
      session[:user_email] = @user.email
      # TODO: redirect to homepage
      redirect_to projects_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
