class SettingsController < ApplicationController
  def show
    @marques   = Marque.par_nom
    @vetements = Liste.par_kind("vetement")
    @matieres  = Liste.par_kind("matiere")
  end
end
