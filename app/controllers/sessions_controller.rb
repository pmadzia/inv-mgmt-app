class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create omniauth ]
  rate_limit to: 10, within: 3.minutes, only: :create,
             with: -> { redirect_to new_session_path, alert: t("sessions.create.rate_limited") }

  def new
  end

  def create
    user = User.authenticate_by(params.permit(:email_address, :password))

    if user&.blocked?
      redirect_to new_session_path, alert: t(".account_blocked")
    elsif user&.authenticate(params[:password])
      start_new_session_for user
      redirect_to after_authentication_url, notice: t(".success")
    else
      redirect_to new_session_path, alert: t(".invalid_credentials")
    end
  end

  def destroy
    terminate_session
    redirect_to root_path, status: :see_other, notice: t(".signed_out")
  end

  def omniauth
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      if user&.blocked?
        redirect_to new_session_path, alert: t(".account_blocked")
      else
        start_new_session_for user
        redirect_to after_authentication_url, notice: t(".success")
      end
    else
      redirect_to new_session_path, alert: t(".email_already_used")
    end
  end
end
