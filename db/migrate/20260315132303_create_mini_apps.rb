class CreateMiniApps < ActiveRecord::Migration[8.1]
  def change
    create_table :mini_apps do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.text :description
      t.string :author
      t.string :category
      t.text :tags, array: true, default: []
      t.string :thumbnail_url
      t.string :route_prefix
      t.string :version
      t.boolean :is_published, default: false
      t.integer :play_count, default: 0
      t.timestamps
    end

    add_index :mini_apps, :slug, unique: true
  end
end
