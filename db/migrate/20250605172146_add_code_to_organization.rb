class AddCodeToOrganization < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :code, :string
    add_index :organizations, :code, unique: true
  end
end
