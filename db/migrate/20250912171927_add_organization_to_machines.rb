class AddOrganizationToMachines < ActiveRecord::Migration[8.0]
  def change
    add_reference :machines, :organization, null: false, foreign_key: true
  end
end
