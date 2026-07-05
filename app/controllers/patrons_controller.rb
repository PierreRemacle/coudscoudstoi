class PatronsController < ApplicationController
  before_action :set_patron, only: [ :show, :edit, :update, :destroy ]

  def index
    @patrons = Patron.includes(:marque, photos_attachments: :blob)
    @patrons = @patrons.par_marque(params[:marque_id])
    @patrons = @patrons.par_genre(params[:genre])
    @patrons = @patrons.par_vetement(params[:vetement])
    @patrons = @patrons.par_difficulte(params[:difficulte])
    @patrons = @patrons.par_matiere(params[:matiere])
    @patrons = @patrons.metrage_min(params[:metrage_min])
    @patrons = @patrons.metrage_max(params[:metrage_max])
    @patrons = @patrons.depuis(params[:depuis])
    @patrons = @patrons.jusqu_au(params[:jusqu_au])
    @patrons = @patrons.recherche(params[:q])
    @patrons = @patrons.recents

    @total_patrons = Patron.count
    @marques = Marque.par_nom
  end

  def show
    @notes = @patron.notes.order(created_at: :asc)
    @note  = Note.new
  end

  def new
    @patron  = Patron.new
    @marques = Marque.par_nom
  end

  def create
    @patron = Patron.new(patron_params.merge(ajoute_par: current_user))
    if @patron.save
      redirect_to patron_path(@patron), notice: "Patron « #{@patron.nom} » créé avec succès."
    else
      @marques = Marque.par_nom
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @marques = Marque.par_nom
    @notes   = @patron.notes.order(created_at: :asc)
    @note    = Note.new
  end

  def update
    if @patron.update(patron_params)
      redirect_to patron_path(@patron), notice: "Patron mis à jour."
    else
      @marques = Marque.par_nom
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patron.destroy
    redirect_to patrons_path, notice: "Patron supprimé.", status: :see_other
  end

  private

  def set_patron
    @patron = Patron.find(params[:id])
  end

  def patron_params
    permitted = params.require(:patron).permit(
      :nom, :marque_id, :genre, :vetement,
      :taille_type, :metrage, :matiere, :poids, :difficulte,
      tailles: [], supports: [], photos: [], fichiers: []
    )
    # Strip empty strings left by the browser, keep only real uploaded files
    permitted[:photos]   = permitted[:photos]&.select   { |f| f.respond_to?(:read) }
    permitted[:fichiers] = permitted[:fichiers]&.select { |f| f.respond_to?(:read) }
    # Don't clear existing attachments when no new files were selected
    permitted.delete(:photos)   if permitted[:photos].blank?
    permitted.delete(:fichiers) if permitted[:fichiers].blank?
    permitted
  end
end
