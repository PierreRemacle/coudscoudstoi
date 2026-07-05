class CreateMarques < ActiveRecord::Migration[8.1]
  def change
    create_table :marques do |t|
      t.string :nom, null: false

      t.timestamps
    end
    add_index :marques, :nom, unique: true
  end
end
