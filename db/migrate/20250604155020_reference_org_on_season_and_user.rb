class ReferenceOrgOnSeasonAndUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :current_organization_id, :integer, null: true
    add_reference :seasons, :organization, foreign_key: true
  end
end
