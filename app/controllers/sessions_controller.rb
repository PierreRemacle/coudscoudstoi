class SessionsController < ApplicationController
  layout "auth"
  skip_before_action :require_auth
  skip_before_action :require_profile

  def new
  end

  def create
    if params[:password] == Rails.application.credentials.app_password
      session[:authenticated] = true
      redirect_to profile_path
    else
      flash.now[:alert] = "Mot de passe incorrect."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end
end
