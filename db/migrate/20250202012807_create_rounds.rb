class CreateRounds < ActiveRecord::Migration[8.0]
  def change
    create_table :rounds do |t|
      t.references :season, null: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
