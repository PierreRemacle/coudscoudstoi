class CreatePatrons < ActiveRecord::Migration[8.1]
  def change
    create_table :patrons do |t|
      t.string :nom, null: false
      t.references :marque, null: true, foreign_key: true
      t.integer :genre, null: false, default: 0
      t.string :vetement
      t.integer :annee
      t.integer :taille_type, default: 0
      t.text :tailles, default: "[]"
      t.decimal :metrage, precision: 5, scale: 2
      t.string :matiere
      t.integer :poids
      t.integer :difficulte
      t.text :supports, default: "[]"
      t.string :ajoute_par, null: false

      t.timestamps
    end

    add_index :patrons, :genre
    add_index :patrons, :difficulte
    add_index :patrons, :vetement
  end
end
