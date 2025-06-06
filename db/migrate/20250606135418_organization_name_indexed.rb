class OrganizationNameIndexed < ActiveRecord::Migration[8.0]
  def change
    add_index :organizations, :name, unique: true
  end
end
