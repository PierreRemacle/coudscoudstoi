class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.string :nom, null: false

      t.timestamps
    end
    add_index :profiles, :nom, unique: true
  end
end
