class Note < ApplicationRecord
  belongs_to :patron

  PALETTE = %w[#5b50e3 #2f9e6b #d8a23a #d05a4e #0d9488 #7c3aed #d97706 #0284c7].freeze

  validates :auteur,  presence: true
  validates :contenu, presence: true

  before_validation :set_couleur

  private

  def set_couleur
    return if auteur.blank?
    self.couleur ||= PALETTE[auteur.bytes.sum % PALETTE.size]
  end
end
