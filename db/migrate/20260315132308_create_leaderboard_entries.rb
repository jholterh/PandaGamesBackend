class CreateLeaderboardEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :leaderboard_entries do |t|
      t.references :mini_app, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :score, null: false
      t.jsonb :metadata, default: {}
      t.datetime :achieved_at, null: false
      t.timestamps
    end

    add_index :leaderboard_entries, [ :mini_app_id, :score ], order: { score: :desc }
  end
end
