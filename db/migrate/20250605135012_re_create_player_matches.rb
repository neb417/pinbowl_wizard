class ReCreatePlayerMatches < ActiveRecord::Migration[8.0]
  def change
    create_table :player_matches do |t|
      t.references :user, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.integer :score
      t.integer :result, default: 0

      t.timestamps
    end
  end
end
