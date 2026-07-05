class ProfilesController < ApplicationController
  layout "auth"
  skip_before_action :require_profile

  def show
    @profiles = Profile.par_nom
    @new_profile = Profile.new
  end

  def update
    profile = Profile.find_by(nom: params[:name])
    if profile
      session[:current_user] = profile.nom
      redirect_to root_path
    else
      redirect_to profile_path, alert: "Profil inconnu."
    end
  end

  def create
    @new_profile = Profile.new(profile_params)
    if @new_profile.save
      session[:current_user] = @new_profile.nom
      redirect_to root_path
    else
      @profiles = Profile.par_nom
      render :show, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:nom)
  end
end
