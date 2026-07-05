class Marque < ApplicationRecord
  has_many :patrons, dependent: :nullify

  validates :nom, presence: true, uniqueness: { case_sensitive: false }

  scope :par_nom, -> { order(:nom) }
end
