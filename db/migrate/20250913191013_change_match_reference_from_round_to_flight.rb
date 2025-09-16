class ChangeMatchReferenceFromRoundToFlight < ActiveRecord::Migration[8.0]
  def change
    change_table :matches do |t|
      t.remove_references :round
      t.references :flight, null: false, foreign_key: true
    end
  end
end
