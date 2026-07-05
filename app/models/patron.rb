class Patron < ApplicationRecord
  belongs_to :marque, optional: true
  has_many   :notes,  dependent: :destroy

  has_many_attached :photos
  has_many_attached :fichiers

  attribute :tailles,  :json, default: []
  attribute :supports, :json, default: []

  enum :genre,       { femme: 0, homme: 1, enfant: 2, bebe: 3, accessoire: 4, autre: 5 }
  enum :poids,       { leger: 0, moyen: 1, lourd: 2 }
  enum :difficulte,  { facile: 0, moyenne: 1, difficile: 2 }
  enum :taille_type, { lettres: 0, chiffres: 1 }

  validates :nom,       presence: true
  validates :ajoute_par, presence: true
  validates :annee,     numericality: { only_integer: true,
                                        greater_than_or_equal_to: 1950,
                                        less_than_or_equal_to: 2100,
                                        allow_nil: true }
  validates :metrage,   numericality: { greater_than: 0, allow_nil: true }
  validate  :photos_are_images

  scope :par_marque,     ->(id) { where(marque_id: id) if id.present? }
  scope :par_genre,      ->(g)  { where(genre: Array(g).compact.reject(&:empty?)) if Array(g).any?(&:present?) }
  scope :par_vetement,   ->(v)  { where(vetement: Array(v).compact.reject(&:empty?)) if Array(v).any?(&:present?) }
  scope :par_difficulte, ->(d)  { where(difficulte: Array(d).compact.reject(&:empty?)) if Array(d).any?(&:present?) }
  scope :par_matiere,    ->(m)  { where(matiere: Array(m).compact.reject(&:empty?)) if Array(m).any?(&:present?) }
  scope :metrage_max,    ->(m)  { where("metrage <= ?", m.to_f) if m.present? }
  scope :metrage_min,    ->(m)  { where("metrage >= ?", m.to_f) if m.present? }
  scope :depuis,         ->(d)  { where("created_at >= ?", Date.parse(d).beginning_of_day) if d.present? rescue nil }
  scope :jusqu_au,       ->(d)  { where("created_at <= ?", Date.parse(d).end_of_day) if d.present? rescue nil }
  scope :par_support, ->(supports) {
    vals = Array(supports).flatten.compact.reject(&:empty?)
    vals.reduce(all) { |chain, val| chain.where("supports LIKE ?", "%#{val}%") } if vals.any?
  }
  scope :recherche, ->(q) do
    if q.present?
      joins("LEFT JOIN marques ON marques.id = patrons.marque_id")
        .where("patrons.nom LIKE :q OR marques.nom LIKE :q", q: "%#{q}%")
    end
  end
  scope :recents, -> { order(created_at: :desc) }

  private

  def photos_are_images
    photos.each do |photo|
      unless photo.content_type.start_with?("image/")
        errors.add(:photos, "doit être une image (JPG, PNG, etc.)")
        break
      end
    end
  end
end
