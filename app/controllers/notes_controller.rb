class NotesController < ApplicationController
  before_action :set_patron

  def create
    @note = @patron.notes.build(note_params)
    if @note.save
      redirect_to patron_path(@patron), notice: "Note ajoutée."
    else
      redirect_to patron_path(@patron), alert: @note.errors.full_messages.to_sentence
    end
  end

  def destroy
    @note = @patron.notes.find(params[:id])
    @note.destroy
    redirect_to patron_path(@patron), notice: "Note supprimée.", status: :see_other
  end

  private

  def set_patron
    @patron = Patron.find(params[:patron_id])
  end

  def note_params
    params.require(:note).permit(:auteur, :contenu)
  end
end
