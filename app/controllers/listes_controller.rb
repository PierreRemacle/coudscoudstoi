class ListesController < ApplicationController
  def create
    Liste.create(liste_params)
    redirect_to settings_path
  end

  def destroy
    item = Liste.find(params[:id])
    column = item.kind
    count = Patron.where(column => item.valeur).count
    if count > 0
      redirect_to settings_path, alert: "Impossible de supprimer « #{item.valeur} » : #{count} patron#{"s" if count > 1} l'utilise#{"nt" if count > 1} encore."
    else
      item.destroy
      redirect_to settings_path, notice: "« #{item.valeur} » supprimé."
    end
  end

  private

  def liste_params
    params.require(:liste).permit(:kind, :valeur)
  end
end
