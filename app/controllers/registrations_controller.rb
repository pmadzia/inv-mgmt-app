class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  def new
    @user = User.new
  end

  def create
    @user = User.new(get_user_params)
    if @user.save
      redirect_to new_session_path, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def get_user_params
    params.require(:user).permit(:name, :email_address, :password)
  end
end
