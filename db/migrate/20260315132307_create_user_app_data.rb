class CreateUserAppData < ActiveRecord::Migration[8.1]
  def change
    create_table :user_app_data do |t|
      t.references :user, null: false, foreign_key: true
      t.references :mini_app, null: false, foreign_key: true
      t.jsonb :data, default: {}
      t.integer :high_score, default: 0
      t.integer :play_count, default: 0
      t.datetime :last_played_at
      t.timestamps
    end

    add_index :user_app_data, [ :user_id, :mini_app_id ], unique: true
  end
end
