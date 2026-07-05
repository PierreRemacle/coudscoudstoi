class ProfilesController < ApplicationController
  layout "auth", only: [ :show, :update, :create ]
  skip_before_action :require_profile, only: [ :show, :update, :create ]

  def manage
    @profiles    = Profile.par_nom
    @new_profile = Profile.new
  end

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

  def destroy
    profile = Profile.find(params[:id])
    if profile.nom != current_user
      redirect_to manage_profile_path, alert: "Vous ne pouvez supprimer que votre propre profil."
    elsif Profile.count <= 1
      redirect_to manage_profile_path, alert: "Impossible de supprimer le dernier profil."
    else
      profile.destroy
      reset_session
      redirect_to new_session_path, notice: "Profil supprimé. Veuillez vous reconnecter."
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:nom)
  end
end
