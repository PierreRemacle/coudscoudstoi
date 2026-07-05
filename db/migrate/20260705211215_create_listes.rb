class CreateListes < ActiveRecord::Migration[8.1]
  def change
    create_table :listes do |t|
      t.string :kind, null: false
      t.string :valeur, null: false

      t.timestamps
    end

    add_index :listes, [:kind, :valeur], unique: true
  end
end
