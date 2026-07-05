class CreateNotes < ActiveRecord::Migration[8.1]
  def change
    create_table :notes do |t|
      t.references :patron, null: false, foreign_key: true
      t.string :auteur,  null: false
      t.string :couleur, null: false
      t.text   :contenu, null: false

      t.timestamps
    end
  end
end
