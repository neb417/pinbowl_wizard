class CreateFlights < ActiveRecord::Migration[8.0]
  def change
    create_table :flights do |t|
      t.references :round, null: false, foreign_key: true

      t.timestamps
    end
  end
end
