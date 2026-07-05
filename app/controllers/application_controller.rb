class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :require_auth
  before_action :require_profile

  private

  def require_auth
    redirect_to new_session_path unless session[:authenticated]
  end

  def require_profile
    redirect_to profile_path unless session[:current_user].present?
  end

  def current_user
    session[:current_user]
  end
  helper_method :current_user
end
