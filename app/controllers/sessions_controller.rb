class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params.dig(:session, :email)&.downcase)
    if user&.authenticate(params.dig(:session, :password))
      perform_login user
    else
      flash.now[:danger] = t "controller.sessions_c.invalid"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_path, status: :see_other
  end

  private

  def perform_login user
    if user.activated?
      params.dig(:session, :remember_me) == "1" ? remember(user) : forget(user)
      log_in user
      redirect_back_or user
    else
      flash[:warning] = t("controller.sessions_c.acc_not_active")
      redirect_to root_url, status: :see_other
    end
  end
end
