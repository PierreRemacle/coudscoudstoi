class MarquesController < ApplicationController
  def new
    @marque = Marque.new
  end

  def create
    @marque = Marque.new(marque_params)
    if @marque.save
      redirect_to new_patron_path, notice: "Marque « #{@marque.nom} » ajoutée."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def marque_params
    params.require(:marque).permit(:nom)
  end
end
