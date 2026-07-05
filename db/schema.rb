# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_05_123612) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "marques", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "nom", null: false
    t.datetime "updated_at", null: false
    t.index ["nom"], name: "index_marques_on_nom", unique: true
  end

  create_table "notes", force: :cascade do |t|
    t.string "auteur", null: false
    t.text "contenu", null: false
    t.string "couleur", null: false
    t.datetime "created_at", null: false
    t.integer "patron_id", null: false
    t.datetime "updated_at", null: false
    t.index ["patron_id"], name: "index_notes_on_patron_id"
  end

  create_table "patrons", force: :cascade do |t|
    t.string "ajoute_par", null: false
    t.integer "annee"
    t.datetime "created_at", null: false
    t.integer "difficulte"
    t.integer "genre", default: 0, null: false
    t.integer "marque_id"
    t.string "matiere"
    t.decimal "metrage", precision: 5, scale: 2
    t.string "nom", null: false
    t.integer "poids"
    t.text "supports", default: "[]"
    t.integer "taille_type", default: 0
    t.text "tailles", default: "[]"
    t.datetime "updated_at", null: false
    t.string "vetement"
    t.index ["difficulte"], name: "index_patrons_on_difficulte"
    t.index ["genre"], name: "index_patrons_on_genre"
    t.index ["marque_id"], name: "index_patrons_on_marque_id"
    t.index ["vetement"], name: "index_patrons_on_vetement"
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "nom", null: false
    t.datetime "updated_at", null: false
    t.index ["nom"], name: "index_profiles_on_nom", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "notes", "patrons"
  add_foreign_key "patrons", "marques"
end
