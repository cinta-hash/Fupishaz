

ActiveRecord::Schema[7.1].define(version: 2024_01_25_130414) do
  create_table "links", force: :cascade do |t|
    t.string "long_url"
    t.string "short_url"
    t.string "custom_url"
    t.integer "clicks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
