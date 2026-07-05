class Profile < ApplicationRecord
  validates :nom, presence: true, uniqueness: { case_sensitive: false }

  scope :par_nom, -> { order(:nom) }
end
