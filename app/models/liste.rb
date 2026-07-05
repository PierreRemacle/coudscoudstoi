class Liste < ApplicationRecord
  KINDS = %w[vetement matiere].freeze

  validates :kind, inclusion: { in: KINDS }
  validates :valeur, presence: true, uniqueness: { scope: :kind, case_sensitive: false }

  scope :par_kind, ->(k) { where(kind: k).order(:valeur) }

  def self.valeurs(kind)
    par_kind(kind).pluck(:valeur)
  end
end
